init:
	docker-compose build & make db-setup && docker-compose run --rm web rails credentials:edit
rspec:
	docker-compose run --rm web_test rspec
rubocop:
	docker-compose run --rm web rubocop
rubocop-fix:
	docker-compose run --rm web rubocop -A
db-setup:
	docker-compose run --rm web rails db:create && docker-compose run --rm web rails db:migrate
db-migrate:
	docker-compose run --rm web rails db:migrate
db-seed:
	docker-compose run --rm web rails db:seed
bundle:
	docker-compose run --rm web bundle
bundle-update:
	docker-compose run --rm web bundle update
annotate-models:
	docker-compose run --rm web bundle exec annotate --models --exclude fixtures
swaggerize:
	docker-compose run --rm web_test rake rswag:specs:swaggerize