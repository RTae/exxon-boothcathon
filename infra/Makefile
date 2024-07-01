.PHONY: help gen-tf-docs format-tf init plan apply destroy

help:
	@echo "Usage: make [target]"
	@echo "Targets:"
	@echo " gen-tf-docs - Generate Terraform documentation"
	@echo " format-tf   - Format Terraform code"
	@echo ""
	@echo "Usage: make [target] ENV=[environment]"
	@echo "Targets:"
	@echo " int     - Initialize the Terraform backend"
	@echo " plan    - Generate and show an execution plan"
	@echo " apply   - Builds or changes infrastructure"
	@echo " destroy - Destroy Terraform-managed infrastructure"
	@echo " help    - Show this help message"
	@echo ""

define terragrunt_command
	cd ./configs && terragrunt $(2) $(3)
endef

TEMPLATES_DIR = ./modules/*
gen-tf-docs:
	@terraform-docs markdown table --output-file README.md --output-mode inject ./ --sort=false
	@$(foreach file, $(wildcard $(TEMPLATES_DIR) ), \
		terraform-docs markdown table --output-file README.md --output-mode inject $(file) --sort=false ;)

format-tf:
	terraform fmt -diff

init plan:
	$(call terragrunt_command,$@,)

apply destroy:
	$(call terragrunt_command,$@,-auto-approve)
%:
	make help
