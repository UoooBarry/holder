rspec:
	docker-compose run --rm web_test rspec
rubocop:
	docker-compose run --rm web rubocop
rubocop-fix:
	docker-compose run --rm web rubocop --auto-correct
db-setup:
	docker-compose run --rm web rails db:create && docker-compose run --rm web rails db:migrate
db-seed:
	docker-compose run --rm web rails db:seed