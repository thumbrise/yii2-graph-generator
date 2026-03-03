#!/usr/bin/env bash

composer install --no-dev
composer du
#migrate
#storage link
#npm ci
exec $@