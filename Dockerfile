# Use the official Node.js image as the base image for the build stage
FROM node:20 as angular

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install project dependencies
RUN npm install

# Install Angular CLI globally
# RUN npm install -g @angular/cli

# Copy the entire project to the container
COPY . .

# Build the Angular app for production
RUN npm run build

# Use a smaller, production-ready Nginx image as the final image
FROM nginx:alpine

# Copy the production-ready Angular app to the Nginx webserver's root directory
COPY --from=angular /usr/src/app/dist/rent-acar-front-end /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

