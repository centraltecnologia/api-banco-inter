DOCKER_COMPOSE_DIR=.
DOCKER_COMPOSE_FILE=$(DOCKER_COMPOSE_DIR)/docker-compose.yml
DEFAULT_CONTAINER=fpm
DOCKER_COMPOSE=docker-compose -f $(DOCKER_COMPOSE_FILE) --project-directory $(DOCKER_COMPOSE_DIR)

##@ 
.PHONY: docker-init
docker-init: .env ## Make sure the .env file exists for docker

.PHONY: docker-build-from-scratch
docker-build-from-scratch: docker-init ## Build all docker images from scratch, without cache etc. Build a specific image by providing the service name via: make docker-build CONTAINER=<service>
	$(DOCKER_COMPOSE) rm -fs $(CONTAINER) && \
	$(DOCKER_COMPOSE) build --pull --no-cache --parallel $(CONTAINER) && \
	$(DOCKER_COMPOSE) up -d --force-recreate $(CONTAINER)

.PHONY: docker-tests
docker-tests: ## Run the infrastructure tests for the docker setup
	$(DOCKER_COMPOSE) run pest

.PHONY: docker-build
docker-build: docker-init ## Build all docker images. Build a specific image by providing the service name via: make docker-build CONTAINER=<service>
	$(DOCKER_COMPOSE) build --parallel $(CONTAINER) && \
	$(DOCKER_COMPOSE) up -d --force-recreate $(CONTAINER)

.PHONY: docker-up
docker-up: docker-init ## Start all docker containers. To only start one container, use CONTAINER=<service>
	$(DOCKER_COMPOSE) up -d fpm

.PHONY: docker-down
docker-down: docker-init ## Stop all docker containers. To only stop one container, use CONTAINER=<service>
	$(DOCKER_COMPOSE) down $(CONTAINER)

.PHONY: docker-net
docker-net: ## Get IP address of all containers.
	docker network inspect -f '{{json .Containers}}' standard-php-dev-env_backend | jq '.[] | .Name + ":" + .IPv4Address'