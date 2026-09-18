PROJECT_ID ?= carbon-modem-508909-b3
LOCATION ?= us-central1-a
INSTANCE ?= maskinlaering-i-praksis

.DEFAULT_GOAL := help
.PHONY: help start stop status

help:
	@echo "make start  - Start Workbench"
	@echo "make stop   - Stop Workbench"
	@echo "make status - Show instance status"

start:
	gcloud workbench instances start "$(INSTANCE)" --project="$(PROJECT_ID)" --location="$(LOCATION)"

stop:
	gcloud workbench instances stop "$(INSTANCE)" --project="$(PROJECT_ID)" --location="$(LOCATION)"

status:
	gcloud workbench instances describe "$(INSTANCE)" --project="$(PROJECT_ID)" --location="$(LOCATION)" --format="value(state)"
