# Use an official Node runtime as a base image
FROM node:18.15.0 as builder
 
# Set the working directory to /app
WORKDIR /app
 
# Copy package.json and package-lock.json to the working directory
COPY package*.json ./
 
# Install dependencies
RUN npm install
 
# Copy the rest of the application code to the working directory
COPY . .
 
# Build the Angular app for production
RUN npm run build
 
# Use a smaller base image for the final image
FROM nginx:alpine
 
# Copy the built Angular app to the default Nginx public directory
COPY --from=builder /app/dist/demo-project-muruga /usr/share/nginx/html
 
# Expose port 80 to the outside world
EXPOSE 80
 
# CMD to run the Nginx server
CMD ["nginx", "-g", "daemon off;"]