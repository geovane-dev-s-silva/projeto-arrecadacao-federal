# Carrega pacotes
library(rmarkdown)
library(processx)

# Caminho do dashboard .Rmd
dashboard_path <- "C:\\Users\\User\\Documents\\ProjetoAnaliseIntegrada\\projeto-arrecadacao-federal\\dashboards\\dashbord_arrecadacao.Rmd"

# Define a porta padrão (pode mudar caso já esteja em uso)
porta <- 8787

# Mensagem ao usuário
message("Iniciando dashboard local em http://localhost:", porta)

# Roda o dashboard em segundo plano
rmarkdown::run(
  file = dashboard_path,
  shiny_args = list(port = porta, launch.browser = TRUE)
)

# Caminho do executável ngrok (ajuste se necessário)
ngrok_path <- "ngrok"

# Verifica se o ngrok está instalado
if (Sys.which(ngrok_path) == "") {
  message("⚠️ ngrok não encontrado. Instale em: https://ngrok.com/download")
} else {
  message("🔄 Iniciando ngrok...")
  # Executa o ngrok para expor a porta do dashboard
  ngrok_proc <- process$new(
    command = ngrok_path,
    args = c("http", as.character(porta)),
    stdout = "|", stderr = "|"
  )
  
  # Aguarda o ngrok iniciar e captura a URL pública
  Sys.sleep(3) # Tempo para o ngrok iniciar
  out <- ngrok_proc$read_output_lines()
  
  public_url <- grep("https://", out, value = TRUE)[1]
  
  if (!is.na(public_url)) {
    message("✅ Dashboard disponível publicamente em:")
    message(public_url)
  } else {
    message("⚠️ Não foi possível capturar a URL do ngrok.")
  }
}
