# Use uma imagem oficial do Python
FROM python:3.13-slim

# Define o diretório de trabalho
WORKDIR /app

# Instala dependências do sistema operacional necessárias
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    default-libmysqlclient-dev \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Atualiza pip para a versão mais recente
RUN pip install --no-cache-dir --upgrade pip

# Copia os arquivos de requisitos para o contêiner
COPY requirements.txt /app/requirements.txt

# Instala as dependências do Python
RUN pip install --no-cache-dir --root-user-action=ignore -r /app/requirements.txt

# Copia o restante do código da aplicação para o contêiner
COPY . /app

# Define variáveis de ambiente para produção
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Expõe a porta padrão do Django
EXPOSE 8000

# Comando para iniciar o servidor Django
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
