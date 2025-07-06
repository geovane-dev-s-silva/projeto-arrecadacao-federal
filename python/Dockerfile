FROM python:3.11-slim

# Diretório de trabalho dentro do container
WORKDIR /app

# Instalar dependências básicas
RUN pip install --no-cache-dir fastapi uvicorn pandas

# Expor a porta da API FastAPI
EXPOSE 8000

# Comando que o container vai rodar por padrão
CMD ["uvicorn", "api:app", "--host", "0.0.0.0", "--port", "8000"]