# Use an official Node.js runtime as a parent image
FROM node:16

# Set the working directory to /app
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy all source files to the working directory
COPY . .

# Build the Vue.js application
RUN npm run build

# Expose the app's port
EXPOSE 5173

# Define the command to start the app
CMD ["npm", "run", "dev"]