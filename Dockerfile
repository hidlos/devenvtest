FROM node:boron
RUN mkdir /app
RUN pwd
RUN ls
COPY . /app
WORKDIR /app
RUN pwd
RUN ls
