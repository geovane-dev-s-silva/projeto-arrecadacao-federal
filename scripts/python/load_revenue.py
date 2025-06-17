import pandas as pd
import os

# Caminho do CSV baixado pelo n8n
csv_path = "/data/raw/Arrecadacao_mensal_codigo_GRU.csv"

# Verifica se o arquivo existe
if not os.path.isfile(csv_path):
    print(f"Arquivo não encontrado: {csv_path}")
    exit(1)


try:
    df = pd.read_csv('/data/raw/Arrecadacao_mensal_codigo_GRU.csv', sep=';', encoding='latin1')
    print(df.head())
except Exception as e:
    print(f"Erro ao ler o CSV: {e}")

# Mostra as primeiras linhas
print("\n=== Primeiras linhas ===")
print(df.head())

# Mostra as colunas
print("\n=== Colunas disponíveis ===")
print(df.columns.tolist())

# Informações básicas sobre o dataframe
print("\n=== Info DataFrame ===")
print(df.info())