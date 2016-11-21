FROM node:boron
RUN mkdir /app
RUN hostname
COPY . /app
WORKDIR /app
RUN hostname