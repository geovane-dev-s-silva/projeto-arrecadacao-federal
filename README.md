Com certeza! Abaixo está um modelo de `README.md` para seu projeto de **automação e análise de dados de arrecadação federal com n8n, Python e R**, explicando as etapas e a estrutura de forma clara.

---

## 📊 Projeto de Análise Integrada de Arrecadação Federal

Este projeto realiza a **automação de download, processamento e visualização de dados de arrecadação federal** utilizando uma arquitetura integrada com:

* **n8n** para automação e agendamento
* **Python com FastAPI** para orquestração e API
* **R** para limpeza, análise estatística e geração de dashboard interativo
* **Git** (opcional) para versionamento e publicação dos resultados

---

### 📁 Estrutura do Projeto

```
projeto-arrecadacao-federal/
├── data/                      # Dados brutos (baixados pelo n8n)
│   └── raw/
├── docker-compose.yml         # Arquitetura dos containers (n8n + Python)
├── python/                    # Dockerfile do serviço FastAPI
│   └── Dockerfile
├── scripts/
│   ├── python/
│   │   ├── api.py             # API FastAPI para processar o CSV
│   │   └── load_revenue.py    # Análise bruta (opcional)
│   └── R/
│       ├── importar_dados.R
│       ├── limpar_e_transformar_csv.R
│       ├── dashboard_arrecadacao.Rmd
│       └── gerar_dashboard.R (opcional)
└── .env                       # Variáveis do n8n
```

---

### ⚙️ Funcionalidades

* 🔄 **Automação com n8n**
  Baixa arquivos CSV do portal da Receita Federal e os armazena localmente.

* 🚀 **API com FastAPI (Python)**
  Disponibiliza um endpoint HTTP para acionar o processamento dos dados.

* 📈 **Análise com R**

  * Importa e limpa dados CSV com estrutura irregular
  * Converte datas e valores
  * Agrega informações mensais
  * Gera dashboard interativo com visualizações e estatísticas

* 📤 **Pronto para integração com Git ou publicação automática**

---

### ▶️ Como Executar o Projeto

#### 1. Suba os containers:

```bash
docker-compose up -d --build
```

* Acesse o n8n: [http://localhost:5678](http://localhost:5678)
* Acesse a API FastAPI: [http://localhost:8000/processar\_csv](http://localhost:8000/processar_csv)

#### 2. (Opcional) Rode localmente o dashboard em R:

```r
source("scripts/R/importar_dados.R")         # Para testes simples
rmarkdown::run("scripts/R/dashboard_arrecadacao.Rmd")  # Executa o dashboard
```

---

### ✅ Pré-requisitos

* Docker + Docker Compose
* R ≥ 4.0 com pacotes: `readr`, `dplyr`, `lubridate`, `ggplot2`, `flexdashboard`, `DT`, `rmarkdown`
* Python ≥ 3.10 com: `fastapi`, `pandas`, `uvicorn`

---

### 🌐 Fontes de dados

* Portal da Receita Federal – [Dados Abertos de Arrecadação por GRU](https://www.gov.br/receitafederal/dados-abertos)

---

### 💡 Próximas melhorias (ideias)

* [ ] Agendamento automático de renderização com `rmarkdown::render()`
* [ ] Envio do relatório por e-mail via n8n
* [ ] Deploy da API Python para nuvem
* [ ] Publicação automática do dashboard em GitHub Pages ou Shiny Server

---

### 👨‍💻 Autor

Geovane Santos Silva
Projeto de superação pessoal com foco em integração de tecnologias de automação, análise e visualização de dados públicos.

---