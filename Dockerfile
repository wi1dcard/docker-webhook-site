FROM alpine/git AS clone
WORKDIR /src
RUN git clone --depth 1 https://github.com/fredsted/webhook.site.git /src

FROM composer:1.9 AS build
WORKDIR /src
COPY --from=clone /src .
RUN set -x \
    && composer install --no-interaction --optimize-autoloader --no-dev \
    && find vendor -type d \( -iname 'tests' -o -iname 'test' -o -iname 'docs' -o -iname 'doc' -o -iname 'examples' -o -iname 'build' \) -exec rm -rf {} + \
    && find vendor -not \( -path vendor/phpunit -prune \) -type f \( -iname '*.md' -o -iname 'LICENSE' -o -iname 'phpunit.*' -o -iname '.travis.*' -o -iname 'composer.*' \) ! -iname '*.php' -exec rm -rf {} +

FROM php:7.3-fpm-alpine
COPY --from=build --chown=www-data:www-data /src .
