from fastapi import FastAPI
import pandas as pd
import os

app = FastAPI()

@app.get("/processar_csv")
def processar_csv():
    file_path = "/data/raw/Arrecadacao_mensal_codigo_GRU.csv"


    if not os.path.exists(file_path):
        return {"status": "erro", "mensagem": "Arquivo CSV não encontrado em /data/raw/"}

    try:
        df = pd.read_csv(file_path, sep=';', encoding='latin1')
        linhas = df.shape[0]
        colunas = df.shape[1]
        return {
            "status": "sucesso",
            "linhas": linhas,
            "colunas": colunas,
            "amostra": df.head(5).to_dict(orient="records")
        }
    except Exception as e:
        return {"status": "erro", "mensagem": str(e)}
