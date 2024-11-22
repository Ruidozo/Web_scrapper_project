# Use a imagem base do Python
FROM python:3.10-slim

# Configurações do sistema
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    curl \
    git \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    libffi-dev \
    libssl-dev \
    chromium-driver \
    && apt-get clean



# Configurar o diretório de trabalho dentro do container
WORKDIR /app

# Copiar arquivos de dependências (requirements.txt)
COPY requirements.txt /app/

# Instalar as dependências do Python
RUN pip install --no-cache-dir -r requirements.txt

RUN pip install --upgrade --force-reinstall numpy pandas scipy

# Expõe a porta para Jupyter
EXPOSE 8888

# Comando padrão para iniciar o Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]