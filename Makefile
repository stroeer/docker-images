SERVICE ?= custom-fluent-bit
MODE ?= plan
REGION ?= eu-west-1

ACCOUNT := $(shell aws --output text sts get-caller-identity --query "Account")
ECR_REGISTRY := "$(or $(ACCOUNT),fake).dkr.ecr.$(REGION).amazonaws.com"

# see https://gallery.ecr.aws/aws-observability/aws-for-fluent-bit
UPSTREAM_VERSION := 2.31.10

.PHONY: build
build: ## Builds the custom FluentBit image
	@echo "+ $@"
	@docker buildx build \
		--build-arg "UPSTREAM_VERSION=$(UPSTREAM_VERSION)" \
		--platform linux/amd64,linux/arm64 \
		--tag $(UPSTREAM_VERSION) \
		.

.PHONY: login
login: ## Login to ECR
	@echo "+ $@"
	@aws  --region $(REGION) ecr get-login-password | docker login --username AWS --password-stdin $(ACCOUNT).dkr.ecr.$(REGION).amazonaws.com

.PHONY: push
push: ## Pushes the custom FluentBit image to ECR
	@echo "+ $@"
	@docker buildx build \
		--build-arg "UPSTREAM_VERSION=$(UPSTREAM_VERSION)" \
		--platform linux/amd64,linux/arm64 \
		--push \
		--tag $(ACCOUNT).dkr.ecr.$(REGION).amazonaws.com/$(SERVICE):$(UPSTREAM_VERSION) \
		.

.PHONY: help
help: ## Display this help screen
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

