SERVICE ?= custom-fluent-bit
MODE ?= plan
REGION ?= eu-west-1

ACCOUNT := $(shell aws --output text sts get-caller-identity --query "Account")
ECR_REGISTRY := "$(or $(ACCOUNT),fake).dkr.ecr.$(REGION).amazonaws.com"

# see https://gallery.ecr.aws/aws-observability/aws-for-fluent-bit
UPSTREAM_VERSION := 2.23.1

build: ## Builds the custom FluentBit image
	@echo "+ $@"
	@docker build \
		--build-arg "UPSTREAM_VERSION=$(UPSTREAM_VERSION)" \
		--tag $(ECR_REGISTRY)/$(SERVICE):$(UPSTREAM_VERSION) .

login: ## Login to ECR
	@echo "+ $@"
	@aws  --region $(REGION) ecr get-login-password | docker login --username AWS --password-stdin $(ACCOUNT).dkr.ecr.$(REGION).amazonaws.com

push: build login ## Pushes the custom FluentBit image to ECR
	@echo "+ $@"
	@docker push --all-tags $(ECR_REGISTRY)/$(SERVICE)

.PHONY: help
help: ## Display this help screen
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

