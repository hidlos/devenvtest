FROM node:boron
RUN mkdir -p /app
WORKDIR /app
COPY . /app
RUN npm install
