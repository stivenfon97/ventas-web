FROM php:8.3-apache

# 1. Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
      unzip \
      git \
      curl \
      zip \
      libicu-dev \
      pkg-config \
      build-essential \
      zlib1g-dev \
      libpng-dev \
      libonig-dev \
      libxml2-dev \
      libzip-dev \
      libssl-dev \
      libcurl4-openssl-dev \
      libjpeg-dev \
      libfreetype6-dev \
      libpq-dev \
      libsqlite3-dev \
    # Limpiar al final de la instalación de paquetes
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 2. Configurar e instalar extensiones de PHP
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
      pdo \
      pdo_mysql \
      pdo_sqlite \
      mbstring \
      bcmath \
      fileinfo \
      zip \
      pcntl \
      exif \
      intl \
      gd \
      opcache

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# Install Laravel globaly
RUN composer global require laravel/installer

# add the binary of Laravel to the PATH
ENV PATH="/root/.composer/vendor/bin:$PATH"
RUN echo 'export PATH="$PATH:/root/.composer/vendor/bin"' >> /root/.bashrc

# Install nodejs v22
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs

# Set working directory
WORKDIR /var/www/html/

# Copy existing application directory contents
COPY . /var/www/html

# allow to write in apache2 logs with current user
# RUN chown -R www-data:www-data /var/log/apache2

RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Set permissions
COPY ./docker/php/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh


# Expose port 80
EXPOSE 80
# execute entrypoint
ENTRYPOINT ["entrypoint.sh"]

# Start Apache
CMD ["apache2-foreground"]