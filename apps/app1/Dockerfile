FROM node:boron

# Create app directory
RUN mkdir -p /app
WORKDIR /app

# Install app dependencies
COPY package.json /app
RUN npm install

COPY . /app

EXPOSE 80
CMD [ "node", "index.js" ]