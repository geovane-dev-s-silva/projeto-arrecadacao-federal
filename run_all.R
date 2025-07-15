# Install requirements
source("scripts/R/requirements.R")

# Processa os dados
source("scripts/R/limpar_e_transformar_csv.R")

# Gera o dashboard
rmarkdown::render(
  "dashboards/dashboard_arrecadacao.Rmd",
  output_dir = "outputs/"
)