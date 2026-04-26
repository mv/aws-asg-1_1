
# vscode-modelines
# vim:ft=make:ts=8:sts=8:sw=8:noet:tw=80:nowrap:list

# Makefile for Terragrunt

# Variables
TERRAGRUNT_WORKING_DIR ?= .

SHELL:=bash

_os := $(shell uname -sr)
_uname := $(shell uname -om)
_plat := $(shell uname -om | sed -e 's|x86_64 GNU/Linux|linux_amd64|' \
                                 -e 's|x86_64 Linux|linux_amd64|'  \
                                 -e 's|aarch64 Linux|linux_arm64|' \
                                 -e 's|arm64 Darwin|darwin_arm64|' \
                                 -e 's|Darwin arm64|darwin_arm64|' )
# _os_release := $(shell awk -F= '/^NAME/ {print $$2}' /etc/os-release)
_brew_version := $(shell brew -v)

#_venv := .venv
#_python_version := $(shell python3 -V)

###
### goals/targets/tasks
### (.PHONY: meaning: target is not a file, but a 'task')
###
.DEFAULT_GOAL:= help


################################################################################
##@ Help

.PHONY: help
help:   ## - Default goal: list of targets in Makefile
	@echo
	@echo "  ## Oper.System : [$(_os)]"
	@echo "  ## Unix name   : [$(_uname)]"
	@echo "  ## Platform    : [$(_plat)]"
#	@echo "  ## Distro      : [$(_os_release)]"
	@echo "  ## WSL Distro  : [${WSL_DISTRO_NAME}]"
	@echo "  ## Brew version: [$(_brew_version)]"
#   @echo "  ## Python Version: [$(_python_version)]"
#   @echo "  ## Virtualenv  : [$(_venv)]"

	@awk '\
	  BEGIN { FS = ":.*##"; printf "\nUsage:\n  make \033[01;33m<target>\033[0m\n" }        \
	  /^##@/                  { printf "\n\033[01;37m  %s   \033[0m\n"   , substr($$0, 5) } \
	  /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[01;33m  %-25s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
	@echo


################################################################################
##@ AWS

.PHONY: instance-profile
instance-profile: ## - AWS: create instance-profile
	@echo
	source ./_variables.sh && \
	bin/iam-packer-instance-profile.sh -y

.PHONY: sg-create
sg-create: ## - AWS: create security group
	@echo
	source ./_variables.sh && \
	bin/ec2-security-group-create.sh $${PKR_VAR_vpc_id}

.PHONY: sg-delete
sg-delete: ## - AWS: delete security group rules
	@echo
	source ./_variables.sh && \
	bin/ec2-security-group-delete.sh ec2-packer

.PHONY: gen-var
gen-var: ## $ make gen-var file=config/env.filter   # Generate [_variables.sh]
	@echo
	bin/_gen.pkr-variables.sh $$file
