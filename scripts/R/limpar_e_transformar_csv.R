# Carrega pacotes
library(readr)
library(dplyr)
library(stringr)
library(lubridate)
library(purrr)

# Caminho do CSV
arquivo_csv <- "C:\\Users\\User\\Documents\\ProjetoAnaliseIntegrada\\projeto-arrecadacao-federal\\data\\raw\\Arrecadacao_mensal_codigo_GRU.csv"

# Função para gerar o caminho do arquivo limpo na mesma pasta
caminho_limpo <- function(caminho_original) {
  dir <- dirname(caminho_original)
  nome_arquivo <- tools::file_path_sans_ext(basename(caminho_original))
  extensao <- tools::file_ext(caminho_original)
  file.path(dir, paste0(nome_arquivo, "_limpo.", extensao))
}

arquivo_limpo <- caminho_limpo(arquivo_csv)

# Função aprimorada para processar cada seção do arquivo
processar_secao <- function(linhas, inicio, fim) {
  # Extrai a seção
  secao <- linhas[inicio:fim]
  
  # Encontra a linha do cabeçalho
  cabecalho_idx <- which(str_detect(secao, "Mês Lançamento.*Conta Contábil"))
  
  if (length(cabecalho_idx) == 0) {
    return(NULL)
  }
  
  # Pré-processamento das linhas para tratar valores negativos e remover aspas
  linhas_dados <- secao[(cabecalho_idx + 2):length(secao)] %>%
    str_replace_all('"', '') %>%  # Remove aspas
    str_replace_all('\\(([0-9.,]+)\\)', '-\\1') %>%  # Converte (1.000,00) para -1000.00
    str_trim()
  
  # Lê os dados com tratamento robusto de erros
  dados <- tryCatch({
    read_delim(
      I(linhas_dados),
      delim = "\t",
      locale = locale(encoding = "Latin1", decimal_mark = ",", grouping_mark = "."),
      col_names = c("Mes", "Codigo", "Descricao", "Valor"),
      col_types = cols(
        Mes = col_character(),
        Codigo = col_character(),
        Descricao = col_character(),
        Valor = col_character() # Lemos como texto para tratamento especial
      ),
      trim_ws = TRUE
    )
  }, error = function(e) {
    message("Erro ao ler seção: ", conditionMessage(e))
    return(NULL)
  })
  
  if (is.null(dados)) {
    return(NULL)
  }
  
  # Processamento dos dados
  dados <- dados %>%
    # Remove linhas indesejadas
    filter(!is.na(Mes), 
           !str_detect(Mes, "^Total"), 
           str_detect(Mes, "/")) %>%
    # Converte valor para numérico (tratando negativos e formato brasileiro)
    mutate(
      Valor = str_replace(Valor, "\\.", "") %>% # Remove separador de milhar
             str_replace(",", ".") %>% # Converte decimal para padrão R
             as.numeric(),
      # Conversão robusta de datas (MES/ANO)
      Data = case_when(
        str_detect(Mes, "^[A-Z]{3}/\\d{4}$") ~ parse_date_time(Mes, orders = "b/Y", locale = "pt_BR"),
        str_detect(Mes, "^[A-Z]{3}\\d{4}$") ~ parse_date_time(Mes, orders = "bY", locale = "pt_BR"),
        TRUE ~ NA_Date_
      )
    ) %>%
    # Remove linhas com datas inválidas
    filter(!is.na(Data)) %>%
    select(Data, Codigo, Descricao, Valor)
  
  return(dados)
}

# Lê o arquivo como texto
linhas <- read_lines(arquivo_csv, locale = locale(encoding = "Latin1"))

# Identifica os inícios das seções (por ano)
inicios_secoes <- which(str_detect(linhas, "Ano Lançamento:"))
fins_secoes <- c(inicios_secoes[-1] - 1, length(linhas))

# Processa todas as seções e combina os resultados
dados_finais <- map2_df(inicios_secoes, fins_secoes, ~processar_secao(linhas, .x, .y))

# Verificação de integridade
if (any(is.na(dados_finais$Data))) {
  warning("Existem datas inválidas no conjunto de dados final")
}

if (any(is.na(dados_finais$Valor))) {
  warning("Existem valores inválidos no conjunto de dados final")
}

# Resultado final
print("Prévia dos dados processados:")
print(head(dados_finais))
print(paste("Total de registros processados:", nrow(dados_finais)))

# Salva os dados limpos na mesma pasta do original
write_csv(dados_finais, arquivo_limpo)
message("Arquivo limpo salvo em: ", arquivo_limpo)

