# busca a imagem no dockerhub
FROM node:18-alpine3.19 AS build

# directorio da aplicação dentro imagem base
WORKDIR usr/src/app

# copiar arquivo da aplicacao pra dentro do container
# importar aquivos lock deixa a imagem mais leve
COPY package.json* ./

# Rodar comando dentro do container
# pode rodar um comando linux se necessario (ex apt)
RUN npm install

# copia tudo da aplicacao para dentro do container
COPY . .

# Rodar comando dentro do container
RUN npm run build
RUN npm ci --only=production && npm cache clean --force

# ESTAGIO 2
FROM node:18-alpine3.19

WORKDIR usr/src/app

COPY --from=build /usr/src/app/package.json ./package.json
COPY --from=build /usr/src/app/dist ./dist
COPY --from=build /usr/src/app/node_modules ./node_modules

# Fazer o container rodar na porta 3000
EXPOSE 3000

# Rodar comando dentro do container
CMD ["npm", "run", "start:prod"]

# buildar docker build -t "nome":"versao" .