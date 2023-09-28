# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

The Root module structure we will be using in this oroject is as follows

```
PROJECT_ROOT
│
├── main.tf          #Contains the main configuration for your Terraform infrastructure.
├── outputs.tf       #Defines the output values that can be queried after Terraform applies the configuration.
├── variables.tf     #Declares the variables used in your Terraform configuration.
├── terraform.tfvars #Stores values for the declared variables, typically for sensitive or environment-specific data.
├── providers.tf     #Specifies the providers (e.g., AWS, Azure) and their configurations.
├── README.md        #A documentation file providing information about the project, usage, and important instructions.

```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)
