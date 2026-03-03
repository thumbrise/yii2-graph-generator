FROM php:8.2-fpm-bullseye

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/download/2.7.5/install-php-extensions /usr/local/bin/

RUN apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends \
    zip \
    vim \
    unzip \
    curl \
    bash \
    tzdata \
    libmagickwand-dev \
    qpdf \
    wget \
    default-mysql-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN \
    mv $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini \
    && chmod +x /usr/local/bin/install-php-extensions \
    && install-php-extensions \
    @composer-2.8.5 \
    mbstring \
    exif \
    intl \
    gd \
    pgsql \
    pdo_pgsql \
    bcmath \
    opcache \
    pcntl \
    zip-1.21.1 \
    xhprof-2.3.10 \
    curl-8.12.1 \
    redis-6.0.2 \
    pcov-1.0.12 \
    uv-0.3.0 \
    ast-1.1.2 \
    ssh2-1.4.1 \
    imagick-3.7.0 \
    xdebug-3.4.0

RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get update \
    && apt-get install -y --no-install-recommends nodejs=22.13.0-1nodesource1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN \
    set -xe \
    && delgroup dialout

# Set working directory
WORKDIR /var/www/

ARG DOCKER_HOST_NAME="app"
ARG DOCKER_HOST_UID
ARG DOCKER_HOST_GID

RUN \
    set -xe \
    && groupadd --gid "$DOCKER_HOST_GID" "$DOCKER_HOST_NAME" \
    && useradd --uid "$DOCKER_HOST_UID" --gid "$DOCKER_HOST_GID" --create-home --shell /bin/bash "$DOCKER_HOST_NAME"

USER $DOCKER_HOST_NAME

# Expose port 9000 for PHP-FPM
EXPOSE 9000
