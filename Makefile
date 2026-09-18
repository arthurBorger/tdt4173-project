# Local configuration; command-line overrides (make status LOCATION=...) still work.
-include .env

.DEFAULT_GOAL := help
.PHONY: help start stop status check-config code

export PROJECT_ID LOCATION INSTANCE
export REMOTE_DIR
REMOTE_DIR ?= tdt4173-repo

help:
	@echo "make code   - Start Workbench and open remote VS Code"
	@echo "make start  - Start Workbench"
	@echo "make stop   - Stop Workbench"
	@echo "make status - Show instance status"

check-config:
	@test -n "$(PROJECT_ID)" || { echo "Set PROJECT_ID in .env"; exit 1; }
	@test -n "$(LOCATION)" || { echo "Set LOCATION in .env"; exit 1; }
	@test -n "$(INSTANCE)" || { echo "Set INSTANCE in .env"; exit 1; }

start: check-config
	gcloud workbench instances start "$(INSTANCE)" --project="$(PROJECT_ID)" --location="$(LOCATION)"

stop: check-config
	gcloud workbench instances stop "$(INSTANCE)" --project="$(PROJECT_ID)" --location="$(LOCATION)"

status: check-config
	gcloud workbench instances describe "$(INSTANCE)" --project="$(PROJECT_ID)" --location="$(LOCATION)" --format="value(state)"

code: check-config
	bash scripts/workbench.sh
