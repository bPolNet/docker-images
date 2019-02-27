build: build-composer build-nginx-php-fpm

build-composer:
	docker build ./composer/7.2 -t local-bpol/composer-7.2
	docker build ./composer/7.2-legacy -t local-bpol/composer-7.2-legacy

build-php-cli:
	docker build ./php-cli/7.2 -t local-bpol/php-cli-7.2
	docker build ./php-cli/7.2-legacy -t local-bpol/php-cli-7.2-legacy

build-nginx-php-fpm:
	docker build ./nginx-php-fpm/7.2 -t local-bpol/nginx-php-fpm-7.2
	docker build ./nginx-php-fpm/7.2-legacy -t local-bpol/nginx-php-fpm-7.2-legacy
	docker build ./nginx-php-fpm/7.2-legacy-xdebug -t local-bpol/nginx-php-fpm-7.2-legacy-xdebug
	docker build ./nginx-php-fpm/7.2-xdebug -t local-bpol/nginx-php-fpm-7.2-xdebug
