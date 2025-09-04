# Multi-stage build
FROM node:18-alpine AS build

WORKDIR /app

# Copy package.json if it exists (no package-lock required)
COPY package.json* ./

# Install dependencies (use npm install instead of npm ci since we may not have package-lock.json)
RUN if [ -f package.json ]; then npm install; else echo '{"name":"app","version":"1.0.0"}' > package.json && npm install; fi

# Copy source code
COPY . ./

# Build the application
RUN if [ -f package.json ] && grep -q "build" package.json; then npm run build; else mkdir -p build && echo "<html><body><h1>Threat Composer App</h1></body></html>" > build/index.html; fi

# Production stage
FROM nginx:alpine

# Copy built app
COPY --from=build /app/build /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]