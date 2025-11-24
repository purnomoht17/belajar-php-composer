FROM php:8.1-fpm 

# Instal dependensi sistem yang diperlukan (git, unzip, dll.)
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libonig-dev \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Instal ekstensi PHP
RUN docker-php-ext-install pdo pdo_mysql zip opcache bcmath mbstring

# Instal Composer secara global
# Mengunduh installer Composer resmi dan memindahkannya ke /usr/local/bin
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Tambahkan user non-root (www-data) untuk keamanan dan izin file
# Menggunakan variabel lingkungan dari docker-compose.yml (UID/GID)
ARG UID=1000
ARG GID=1000
RUN usermod -u ${UID} www-data && groupmod -g ${GID} www-data

# Tetapkan direktori kerja
WORKDIR /var/www/html

# Atur user default ke www-data
USER www-data