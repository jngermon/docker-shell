COMPOSER_URL=https://getcomposer.org/composer.phar
COMPOSER=./composer.phar

all: vendor

vendor: $(COMPOSER)
	"$(COMPOSER)" install

$(COMPOSER):
	wget --no-use-server-timestamps -nv -O "$(COMPOSER)" "$(COMPOSER_URL)"
	chmod +x "$(COMPOSER)"

docker-compose.env: docker-compose.env.dist
	@ cp docker-compose.env.dist docker-compose.env
	@ sed --in-place "s/{your_unix_local_username}/$(shell whoami)/" docker-compose.env
	@ sed --in-place "s/{your_unix_local_uid}/$(shell id --user)/" docker-compose.env

