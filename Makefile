SHELL := /bin/bash
.DEFAULT_GOAL := help

ROOT_PATH := $(abspath $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST))))))
BIN_PATH := $(ROOT_PATH)/.local/bin

ENV_VARS ?= $(ROOT_PATH)/init/envvars.env
ifneq (,$(wildcard $(ENV_VARS)))
include $(ENV_VARS)
export $(shell sed 's/=.*//' $(ENV_VARS))
endif

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
