# syntax=docker/dockerfile:1.4

# Development stage
FROM node:lts AS development

WORKDIR /code

# Set environment variables
ENV CI=true
ENV PORT=3000

# Copy package files and install dependencies
COPY package*.json /code/
RUN npm ci

# Copy the rest of the code
COPY . /code/

# Start the development server
CMD [ "npm", "start" ]

# Development environment stage
FROM development AS dev-envs

# Install git and add vscode user
RUN apt-get update \
  && apt-get install -y git \
  && apt-get clean \
  && useradd -s /bin/bash -m vscode \
  && groupadd docker \
  && usermod -aG docker vscode

# Install Docker tools (cli, buildx, compose)
COPY --from=gloursdocker/docker / /

# Build stage
FROM development AS build

# Build the production-ready code
RUN ["npm", "run", "build"]

# Production stage
FROM nginx:1.13-alpine AS production

# Copy the production-ready code to the nginx server
COPY --from=build /code/build /usr/share/nginx/html

# # Set security context for nginx
# RUN chown -R nginx:nginx /usr/share/nginx/html && \
#   chmod -R 755 /usr/share/nginx/html

# # Set container security context
# RUN chown -R nginx:nginx /var/cache/nginx && \
#   chown -R nginx:nginx /var/log/nginx && \
#   chown -R nginx:nginx /var/run && \
#   chown -R nginx:nginx /etc/nginx/conf.d && \
#   chmod -R 755 /var/cache/nginx && \
#   chmod -R 755 /var/log/nginx && \
#   chmod -R 755 /var/run && \
#   chmod -R 755 /etc/nginx/conf.d  && \
#   touch /var/run/nginx.pid && \
#   chmod -R 755 /var/run/nginx.pid

# # Drop privileges
# USER nginx

# Expose port 80
# EXPOSE 8080