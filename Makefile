SERVICE ?= custom-fluent-bit
MODE ?= plan
TF_VAR_region ?= eu-west-1
TF_VAR_app_suffix ?=

ACCOUNT := $(shell aws --output text sts get-caller-identity --query "Account")
ECR_REGISTRY := "$(or $(ACCOUNT),fake).dkr.ecr.$(TF_VAR_region).amazonaws.com"
ECR_REPOSITORY := $(SERVICE)$(TF_VAR_app_suffix)

IMAGE_TAG ?= $(shell git rev-parse --short HEAD)

TF_BACKEND_CFG := -backend-config=bucket=terraform-state-${ACCOUNT}-$(TF_VAR_region) \
	-backend-config=region=$(TF_VAR_region) \
	-backend-config=key="regional/service/$(SERVICE)$(TF_VAR_app_suffix)/terraform.tfstate"

export TF_VAR_region
export TF_VAR_app_suffix
tf ::
	terraform -chdir=terraform init -upgrade $(TF_BACKEND_CFG)
	terraform -chdir=terraform $(MODE)


build ::
	docker build \
		--tag $(ECR_REGISTRY)/$(ECR_REPOSITORY):$(IMAGE_TAG) \
		--tag $(ECR_REGISTRY)/$(ECR_REPOSITORY):testing .

ecr_login ::
	aws  --region $(TF_VAR_region) ecr get-login-password | docker login --username AWS --password-stdin $(ACCOUNT).dkr.ecr.$(TF_VAR_region).amazonaws.com

push :: build ecr_login
	docker push --all-tags $(ECR_REGISTRY)/$(ECR_REPOSITORY)
