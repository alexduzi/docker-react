FROM node:lts-alpine AS builder

WORKDIR '/app'

COPY package.json .

RUN npm config set registry http://registry.npmjs.org/ --global

RUN npm config set  https-proxy null

RUN npm config set  proxy null

RUN npm config set strict-ssl false

RUN npm set maxsockets 3

RUN npm install --force --verbose

COPY . .

RUN npm run build

FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html