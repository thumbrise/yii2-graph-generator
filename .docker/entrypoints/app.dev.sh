#!/usr/bin/env bash

composer install
composer du
#migrate with seeds
#link storage
#npm ci
exec $@