# 1. Build stage
FROM node:24 AS builder

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all project files
COPY . .

# Build Angular app for production
RUN npm run build --prod

# 2. Production stage
FROM nginx:1.25-alpine

# Remove default Nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy Angular build output to Nginx
COPY --from=builder /app/dist/TestAngular/browser /usr/share/nginx/html

# Optional: copy custom Nginx config
#COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
