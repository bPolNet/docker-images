

build:
	docker build ./nginx-php-fpm/7.2 -t nginx-php-fpm-7.2-test
	docker build ./nginx-php-fpm/7.2-legacy -t nginx-php-fpm-7.2-legacy-test
	docker build ./nginx-php-fpm/7.2-legacy-xdebug -t nginx-php-fpm-7.2-legacy-xdebug-test
	docker build ./nginx-php-fpm/7.2-xdebug -t nginx-php-fpm-7.2-xdebug-test
