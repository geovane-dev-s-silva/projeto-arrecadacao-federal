
import pandas as pd
import os

# Caminho do CSV baixado pelo n8n
csv_path = "/data/raw/arrecadacao-tributo.csv"

# Verifica se o arquivo existe
if not os.path.isfile(csv_path):
    print(f"Arquivo não encontrado: {csv_path}")
    exit(1)

# Lê o CSV (ajuste o encoding e separador se necessário)
try:
    df = pd.read_csv(csv_path, sep=';', encoding='utf-8', low_memory=False)
except Exception as e:
    print(f"Erro ao ler o CSV: {e}")
    exit(1)

# Mostra as primeiras linhas
print("\n=== Primeiras linhas ===")
print(df.head())

# Mostra as colunas
print("\n=== Colunas disponíveis ===")
print(df.columns.tolist())

# Informações básicas sobre o dataframe
print("\n=== Info DataFrame ===")
print(df.info())