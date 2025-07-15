# Lista de pacotes necessários
packages <- c(
  "flexdashboard",
  "crosstalk",
  "DT",
  "purrr",
  "readr",
  "dplyr",
  "ggplot2",
  "tidyr",
  "stringr",
  "lubridate"
)

# Instalar apenas os pacotes que ainda não estão instalados
install_if_missing <- function(pkg) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg)
  }
}

invisible(lapply(packages, install_if_missing))
