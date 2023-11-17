#!/bin/sh

# Instala as dependecias
apk add python3
apk add build-base

cd /app

# Espera até que o serviço do banco de dados esteja pronto
while ! nc -z db 3306; do
  echo "Aguardando o serviço do banco de dados iniciar..."
  sleep 1
done

# Instalar dependências
npm install

# Executar migrações do banco de dados
npx sequelize db:migrate

# Executar sementes do banco de dados
npx sequelize db:seed:all

# Iniciar o aplicativo
npm run runner
