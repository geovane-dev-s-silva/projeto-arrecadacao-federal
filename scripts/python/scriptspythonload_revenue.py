import pandas as pd

# URL do CSV (substitua pelo link real)
url = "https://cdn.cade.gov.br/dados_abertos/Dados%20_receitas_previstas_realizadas_lancadas/Arrecadacao_mensal_codigo_GRU.csv"

# Ler os dados diretamente
df = pd.read_csv(url, sep=';', encoding='utf-8')

# Mostrar as primeiras linhas e info básica
print(df.head())
print("\nColunas:", df.columns.tolist())
print(df.info())