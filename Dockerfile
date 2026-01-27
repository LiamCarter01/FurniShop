# Stage 1: Build Flutter Web App
FROM ghcr.io/cirruslabs/flutter:stable AS builder

# Set working directory
WORKDIR /app

# Copy pubspec files first for better caching
COPY pubspec.yaml pubspec.lock* ./

# Get dependencies
RUN flutter pub get

# Copy the rest of the application
COPY . .

# Build the web app with HTML renderer (uses system fonts, no external downloads)
RUN flutter build web --release --dart-define=FLUTTER_WEB_USE_SKIA=false

# Stage 2: Serve with Nginx (minimal image ~7MB)
FROM nginx:alpine-slim AS production

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy built web app from builder stage
COPY --from=builder /app/build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
