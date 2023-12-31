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


## Configuration Drift

### fix when the tf state file is deleted or missing
This can be fixed by importing the resources. This does not work for all resources. Check documentartion for which resource support import
[import s3 resources](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)
`terraform import aws_s3_bucket.bucket bucket-name`

### fix when the resources are accidently deleted
using tf plan this cccan be fixed

### removing random provider

the random provider is removed and the var settings are changed

## Creating modules

### Passing Input Variables

We can pass input variables to our module.
The module has to declare the terraform variables in its own variables.tf

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uid
  bucket_name = var.bucket_name
}
```

### Modules Sources

Using the source we can import the module from various places eg:
- locally
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```


## Static website hosting
[Static Website hosting](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration)

Add the website configuration in the resource to add static website hosting as indicated in the documentation
To output the website endpoint add the following endpoint configs in output files

[Website Endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration#attribute-reference)


## Working with Paths in terraform


### Path Variable

In terraform there is a special variable called `path` that allows us to reference local paths:
- path.module = get the path for the current module
- path.root = get the path for the root module
[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)


resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"
}


### Terraform Locals

Locals allows us to define local variables.
Used when we need transform data into another format and have referenced a varaible.

```tf
locals {
  s3_origin_id = "MyS3Origin"
}
```
[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)

### Terraform Data Sources

Used to gett source data from cloud resources.

This is useful when we want to reference cloud resources without importing them.

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```
[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

### Working with JSON

We use the jsonencode to create the json policy inline in the hcl.

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```

[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)



### Changing the Lifecycle of Resources

[Meta Arguments Lifcycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)


### Terraform Data

Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.

https://developer.hashicorp.com/terraform/language/resources/terraform-data

## Provisioners

Provisioners allow you to execute commands on compute instances eg. a AWS CLI command.

They are not recommended for use by Hashicorp because Configuration Management tools such as Ansible are a better fit, but the functionality exists.

[Provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

### Local-exec

This will execute command on the machine running the terraform commands eg. plan apply

```tf
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}
```

https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec

### Remote-exec

This will execute commands on a machine which you target. You will need to provide credentials such as ssh to get into the machine.

```tf
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}
```
https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec