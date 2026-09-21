# Multi-Environment-Azure-Infrastructure-Platform
Using Terraform automation and reusability features to build a azure resources and environments.


This project demonstrates how Terraform can be used to build and manage reusable, multi-environment infrastructure in Microsoft Azure.

The project provisions core Azure resources including a Resource Group, Virtual Network, multiple Subnets, Network Security Groups, Azure Key Vault, and a Log Analytics Workspace. A reusable Terraform network module is used to reduce duplicated code and allow the same infrastructure design to be deployed across separate **Development (DEV)** and **Production (PROD)** environments.

Terraform state is stored remotely in an Azure Storage Account rather than locally, providing a more realistic approach to state management and preparing the infrastructure for team-based and CI/CD deployments.

### Key concepts demonstrated

* Infrastructure as Code (IaC) with Terraform
* AzureRM Terraform provider
* Terraform variables, outputs, and local values
* Reusable Terraform modules
* `for_each` for creating multiple resources
* DEV and PROD environment separation
* Remote Terraform state using Azure Blob Storage
* Microsoft Entra ID authentication
* Azure RBAC for Terraform state access
* Azure Key Vault and Log Analytics deployment
* Terraform dependency management
* Infrastructure planning, deployment, and destruction

The project provides a foundation for integrating Terraform with **Azure DevOps Pipelines**, where infrastructure changes can later follow a controlled workflow of validation, security scanning, `terraform plan`, approval, and `terraform apply`.
