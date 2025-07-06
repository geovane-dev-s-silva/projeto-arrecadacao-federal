# Carrega pacotes necessários
library(readr)
library(dplyr)
library(lubridate)
library(ggplot2)

# Caminho do arquivo CSV
arquivo_csv <- "../../data/raw/Arrecadacao_mensal_codigo_GRU.csv"

# Importa o CSV (usando ; como separador e encoding correto)
dados <- read_csv2(arquivo_csv, locale = locale(encoding = "Latin1"))

# Visualização rápida
print("Colunas disponíveis:")
print(colnames(dados))

# Mostra primeiras linhas
head(dados)

# Converte a coluna de data (ajuste conforme o nome real da coluna)
# Exemplo comum: dados$Data <- dmy(paste("01", dados$MesAno)) se for tipo "03/2024"
# Supondo que exista uma coluna 'AnoMes' tipo "202403":
if ("AnoMes" %in% names(dados)) {
  dados$AnoMes <- ym(dados$AnoMes)
}

# Resumo de arrecadação total por mês (ajuste nomes conforme colunas reais)
if (all(c("AnoMes", "Valor") %in% names(dados))) {
  resumo_mensal <- dados %>%
    group_by(AnoMes) %>%
    summarise(ArrecadacaoTotal = sum(as.numeric(Valor), na.rm = TRUE))

  print(head(resumo_mensal))
}