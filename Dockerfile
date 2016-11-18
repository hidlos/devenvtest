FROM node:boron
RUN mkdir /app
COPY . /app
WORKDIR /app
RUN npm install
RUN npm test