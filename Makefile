.PHONY: help

help:
    @echo "assessment:0.1.0"

build: ## Build the Docker image
	docker build -t assessment:0.1.0 .

run: ## Create and run the container
	docker run -it assessment:0.1.0