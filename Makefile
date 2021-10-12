
.PHONY: test
test: ## Run the infrastructure tests for the docker setup
	./vendor/bin/pest

.PHONY: run
run: ## Run server
	php -S localhost:8000 -t public