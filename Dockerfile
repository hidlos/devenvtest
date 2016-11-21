FROM node:boron
RUN mkdir /app
COPY . /app
WORKDIR /app