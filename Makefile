COMPOSER_URL=https://getcomposer.org/composer.phar
COMPOSER=./composer.phar

all: test

./vendor/autoload.php: $(COMPOSER)
	"$(COMPOSER)" install

$(COMPOSER):
	wget --no-use-server-timestamps -nv -O "$(COMPOSER)" "$(COMPOSER_URL)"
	chmod +x "$(COMPOSER)"

prepare-tests: ./vendor/autoload.php

unit-test: prepare-tests
	vendor/phpunit/phpunit/phpunit --configuration .

test: unit-test

docker-compose.env: docker-compose.env.dist
	@ cp docker-compose.env.dist docker-compose.env
	@ sed --in-place "s/{your_unix_local_username}/$(shell whoami)/" docker-compose.env
	@ sed --in-place "s/{your_unix_local_uid}/$(shell id --user)/" docker-compose.env

