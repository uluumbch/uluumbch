#!/bin/bash

# Display help message if no arguments are provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 [PHP_VERSION] <command>"
    echo "Example: $0 82 php artisan migrate"
    echo "         $0 php artisan migrate (uses default PHP version 8.3)"
    echo "         $0 composer install (uses default PHP version 8.3)"
    echo "Created by me for simplicity"
    exit 1
fi

# Set the PHP version. Default to 8.3 if the first argument looks like a command (doesn't contain a dot).
if [[ $1 =~ ^[0-9]+\.[0-9]+ ]]; then
    PHP_VERSION="${1//.}"
    shift
else
    PHP_VERSION=83
fi

# Run the Docker container with the specified or default PHP version
docker run --rm \
    -u "$(id -u):$(id -g)" \
    -v "$(pwd):/var/www/html" \
    -w /var/www/html \
    laravelsail/php${PHP_VERSION}-composer:latest \
    "$@"