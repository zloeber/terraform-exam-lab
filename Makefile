SHELL := /bin/bash
.DEFAULT_GOAL := help

ROOT_PATH := $(abspath $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST))))))
BIN_PATH := $(ROOT_PATH)/.local/bin

terraform := $(BIN_PATH)/terraform
tf_state_config := $(ROOT_PATH)/backend.tf

ENV_VARS ?= $(ROOT_PATH)/init/envvars.env
ifneq (,$(wildcard $(ENV_VARS)))
include $(ENV_VARS)
export $(shell sed 's/=.*//' $(ENV_VARS))
endif

# Generic shared variables
ifeq ($(shell uname -m),x86_64)
ARCH ?= "amd64"
endif
ifeq ($(shell uname -m),i686)
ARCH ?= "386"
endif
ifeq ($(shell uname -m),aarch64)
ARCH ?= "arm"
endif
ifeq ($(OS),Windows_NT)
OS := Windows
else
OS := $(shell sh -c 'uname -s 2>/dev/null || echo not' | tr '[:upper:]' '[:lower:]')
endif

TF_VERSION ?= 0.12.24

.PHONY: help
help: ## Help
	@grep --no-filename -E '^[a-zA-Z1-9_/-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: init/git
init/git: ## Initialize this repo and push to github
	rm -rf .git
	git init
	git add --all . && git commit -m 'initial commit'
	git remote add origin git@github.com:${GITHUB_ORGANIZATION}/${TF_VAR_repo_name}.git
	git push -u origin master

.PHONY: deps
deps: .dep/terraform ## Install Dependencies

.PHONY: .dep/terraform
.dep/terraform: ## Install local terraform binary
ifeq (,$(wildcard $(terraform)))
	@echo "Attempting to install terraform - $(TF_VERSION)"
	@mkdir -p $(BIN_PATH)
	@wget -O /tmp/terraform.zip https://releases.hashicorp.com/terraform/$(TF_VERSION)/terraform_$(TF_VERSION)_$(OS)_$(ARCH).zip
	@unzip -d $(BIN_PATH) /tmp/terraform.zip && rm /tmp/terraform.zip
endif