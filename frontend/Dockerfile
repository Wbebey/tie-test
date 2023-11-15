# syntax=docker/dockerfile:1.4

# Development stage
FROM node:lts AS development

WORKDIR /code

# Set environment variables
ENV NODE_ENV=development
ENV CI=true
ENV PORT=3000

# Copy package files and install dependencies
COPY package*.json /code/
RUN npm ci

# Copy the rest of the code
COPY . /code/

# Start the development server
CMD [ "npm", "start" ]