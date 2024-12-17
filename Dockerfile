# Use uma imagem oficial do Python
FROM python:3.13-slim

# Define o diretório de trabalho
WORKDIR /app

# Instala dependências do sistema operacional necessárias
RUN apt-get update && apt-get install -y \
    gcc \
    build-essential \
    libmariadb-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Copia os arquivos de requisitos para o contêiner
COPY requirements.txt /app/requirements.txt

# Instala as dependências do Python
RUN pip install --no-cache-dir -r /app/requirements.txt

# Copia o restante do código da aplicação para o contêiner
COPY . /app

# Define variáveis de ambiente para produção
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Expõe a porta padrão do Django
EXPOSE 8000

# Comando
