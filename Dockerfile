# Getting the base image
FROM node:alpine AS builder
# Defining the base directory inside the container
WORKDIR '/app'
# Copying the package.json file and running it to install all th dependencies
COPY package.json .
RUN npm install
# Copying everything from the development folder to the folder inside the container
COPY . .
# Running the server
RUN npm run build

# Installing base image for server
FROM nginx
# Copying the files created from build step in previous flow to the required directory inside 
# Travis CI so that it can be served
COPY --from=builder /app/build /usr/share/nginx/html