# --- STAGE 1: Build Assets and Dependencies (Node.js/Composer) ---
# Use an appropriate base image for building the application.
FROM node:18-bullseye-slim AS build

# Install PHP and essential tools for composer
RUN apt-get update && apt-get install -y \
    php-cli \
    php-curl \
    php-mbstring \
    php-sqlite3 \
    php-zip \
    git \
    unzip \
    composer

# Set the working directory
WORKDIR /app

# Copy the source code
COPY . .

# Install PHP dependencies using composer
RUN composer install --no-dev --optimize-autoloader

# Build the front-end assets (if Grocy uses Node/NPM for front-end)
# NOTE: Check Grocy's documentation for the exact build command (e.g., npm run build)
# RUN npm install
# RUN npm run build

# --- STAGE 2: Final Runtime Image (Web Server + PHP) ---
# Use the official PHP image optimized for the FPM web server
FROM php:8.2-fpm-bullseye

# Install required PHP extensions for Grocy
RUN apt-get update && apt-get install -y \
    libsqlite3-dev \
    git \
    unzip \
    # Install GD for image manipulation (e.g., barcodes)
    libjpeg-dev \
    libpng-dev \
    libwebp-dev \
    && docker-php-ext-configure gd --with-jpeg --with-png --with-webp \
    && docker-php-ext-install -j$(nproc) pdo pdo_sqlite curl mbstring zip gd

# Set the working directory for the web files
WORKDIR /var/www/html

# Copy the built application files from the 'build' stage
COPY --from=build /app/vendor /var/www/html/vendor
COPY --from=build /app/data /var/www/html/data
COPY --from=build /app/config.php /var/www/html/config.php
COPY . /var/www/html

# Clean up default entrypoint files (if needed, specific to Grocy)
# RUN rm /var/www/html/index.php

# Expose the FPM port (9000 is default for FPM)
EXPOSE 9000

# The default command runs PHP-FPM, ready to be proxied by a web server (like Nginx)
CMD ["php-fpm"]