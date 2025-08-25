FROM php:8.3-apache

# Arguments defined in docker-compose.yml
ARG user
ARG uid

# Install system dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    curl \
    zip \
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
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
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

# RUN apt-get install -y gosu

RUN useradd -m -u ${uid} ${user}

# Apache must use this user
RUN sed -i "s/www-data/${user}/g" /etc/apache2/envvars

# Set working directory
WORKDIR /var/www/html/pi_app

# Copy existing application directory contents
COPY . /var/www/html

# give the same permissions for all project
RUN chown -R ${uid}:${uid} /var/www/html/pi_app

# allow to write in apache2 logs with current user
RUN chown -R ${uid}:${uid} /var/log/apache2

# Set permissions
COPY ./docker/php/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh


# Expose port 80
EXPOSE 80

# Use the user machine no-root
USER ${user}

# execute entrypoint
ENTRYPOINT ["entrypoint.sh"]

# Start Apache
CMD ["apache2-foreground"]
