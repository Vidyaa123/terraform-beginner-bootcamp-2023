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

## Setting up Variables

There ar two types of variables which we can setup in Terraform cloud
- Environment variables
We setup AWS Region, key and access key here in the environemtn variables
- Terraform Variables
All other variables are set here

There are coupke of ways to setup variables.
1. Set up the variable in terraform.tfvars
2. Pass the variable in the cmd line as
` terraform plan -var variable_name='value'`

Since the terraform.tfvars is not commited, the value is stored in temporary example file and passed to the terraform.tfvars file when the project is initiated.
`cp $PROJECT_ROOT/terraform.tfvars.example $PROJECT_ROOT/terraform.tfvars`