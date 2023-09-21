# Terraform Beginner Bootcamp 2023

## Semantic Versioning

This bootcamp project uses Semantic Versioning for its tagging [semver.org](https://semver.org/)

The format for versioning **MAJOR.MINOR.PATCH**,
For eg. 1.0.1

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

##  Install Terraform CLI

The Terraform CLI installation instructions have changed due to gig keyring changes. We need to refer to the latest installation documentation

[Latest CLI installation documentation](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

###  Check for Linux Distribution

This project is built in Ubuntu.
We need to check for the Linux distribtuion and change the scripting needs accordingly

[Documentation t check for OS version of Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/
)

One way to check the version:

```
$ cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy


```

###  Refactoring the bash scripts

While comparing the old code with the new installation code, there is a considerable change in the code.
Hence the installation instructions were added to a bash script here : [./bin/install_terraform_cli]

This was done to keep the [gitpod.yml] file tidy
Also helps in better portability

### Executing the bash script

Executing the bash script can be done by using `./`

eg. `./bin/install_terraform_cli`


While using a bash script in gitpod.yml file, we need to add source to the file

eg. `source ./bin/install_terraform_cli`

### Adding Linux permissions to the script file to execute

In order to make our bash scripts executable we need to change linux permission for the fix to be exetuable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```

alternatively:

```sh
chmod 744 ./bin/install_terraform_cli
```

[Documentation for Linux permissions](https://en.wikipedia.org/wiki/Chmod)


### Gitpod Lifecycle

When using 'Init', the code within 'Init' dies not rerun when the workspace is restarted. So we use 'before'

https://www.gitpod.io/docs/configure/workspaces/tasks


## Setting up Project Root Env Var

env command to show all environment variables

`env | grep gitpod (to filter)`

'env | terraform-beginner-bootcamp-2023`

`Echo $env_var_name`

### Diff methods to set en var

1. In a bash script set the env var and cd into the env var like
 
```
PROJECT_ROOT =‘/workspace/terraform-beginner-bootcamp-2023’

cd $PROJECT_ROOT
```

2. Use export to set the env var in terminal

`
Export PROJECT_ROOT =‘/workspace/terraform-beginner-bootcamp-2023’ `

To unset use `unset PROJECT_ROOT`

3. When a new terminal is opened in vscode the env vars do not persists.

In gitpod you can persist the env var using

`gp env PROJECT_ROOT=‘/workspace/terraform-beginner-bootcamp-2023’`

4. Can also be set in gitpod.yml file, but for not non-sensisitve data.


## Refactor AWS CLI

install AWS CLI through [./bin/install_aws_cli]


We can check if AWS credentials are configured correctly using
```sh
aws sts get-caller-identity
```

AWS Credentials can be set using AWS Configure, but not recommended

[Env variables to configure AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

Create a user in IAM and add to Admin(Admin access to all services) user group. Create User credentials and add to env vars

Add through `export` or `gp env` (to persist) the env vars


## Terraform Random Bucket Name Generation

### Terraform Registry
Terraform registry contains the providers and modules in this url[Terraform Registry](Registry.terraform.io)
-- Providers are direct interfaces to the API
-- Modules are templates created by using code which can be shred and re-used

We will be using a [random provider] (https://registry.terraform.io/providers/hashicorp/random/3.5.1) in this project 

main.tf is the top level module

### Terraform Init
Run terraform Init creates a .terraform file and .terraform.lock.hcl
This downloads the binaries of the providers that will be used in the project
Terraform providers are written in Go and the terraform provider file is downloaded into .terraform folder
This folder doesnt **need to be commited**. Hence ignored in .gitignore

### Terraform plan

`terraform plan`

This command shows the state of the infrastructure and any changeset.

### Terraform Apply

`terraform apply` -- this command will run the plan and and execute the changeset
or 

`terraform apply --auto-approve` -- this command to automatically approve the apply

### Terraform Lock files

`.terraform.lock.hcl` contains the locked versioning for the providers or modulues that should be used with this project.

The Terraform Lock File **should be committed**

### Terraform State Files

`.terraform.tfstate` has the current state of your infrastructure

This file **should not be commited**.
This file contains sensitive data and hence at risk of losing state of infrastructure

### Output the bucket name
Prints the bucket name
`$ terraform output random_bucket_name
"v0TmpsGrE8c3Z8oc"
`

## Simple S3 bucket

Add the provider to main.tf

```sh
aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }

```

Create an s3 bucket with the randamly generated bucket name from earlier commit

```sh
resource "aws_s3_bucket" "example" {
  bucket = random_string.bucket_name.result
}
```


### Terraform destroy

destroys all the resources created

`terraform destroy`

### s3 bucket naming rules

check if the randomly generated bucket name adheres to s3 naming convention.
Alter the code to make all charcters lower and increase the length of the random string

```sh
resource "random_string" "bucket_name" {
  length = 32
  lower = true
  upper = false
  special = false
}
```

## Terraform cloud
By default, Terraform stores its state in the file terraform.tfstate in local filesystem. This works well for personal projects, but working with Terraform in a team, use of a local file makes Terraform usage complicated because each user must make sure they always have the latest state data before running Terraform and make sure that nobody else runs Terraform at the same time.
The best way to do this is by running Terraform in a remote environment with shared access to state. Remote state solves those challenges. Remote state is simply storing that state file remotely, rather than on your local filesystem. With a single state file stored remotely, teams can ensure they always have the most up to date state file.

[Terraform Overview](https://medium.com/devops-mojo/terraform-remote-states-overview-what-is-terraform-remote-state-storage-introduction-936223a0e9d0)



## Connect to Terraform Cloud backend

Create a project and workspace in terraform cloud
use Cli driven run to connect the remote state.
Use the code provided and add it to main.tf
`
cloud {
    organization = "xxxxx"

    workspaces {
      name = "xxxxxxx"
    }
  }`

  Apply `terraform init` and you will end up in a prompt saying not loggied in to terraform cloud
  so type `terraform login` and type 'yes to proceed at prompt
  It will ask for terraform token

use this [link](https://app.terraform.io/app/settings/tokens?source=terraform-login) to generate a token.


Then create a file using the commands in the terminal 
 `touch /home/gitpod/.terraform.d/credentials.tfrc.json`
 `open /home/gitpod/.terraform.d/credentials.tfrc.json`

 copy the code into the credentials file and replace the generated token into this code 
 ```
 {
  "credentials": {
    "app.terraform.io": {
      "token": "F2aaIh5eOhAYcc.atlasv1.7775NOPEzo82qN88elI0qgbcyu3Jr0N4rluUqzIHEgsNf5uRxPfJ7DiV3QzwEXoNOPE"
    }
  }
}
```

Then enter terraform init, plan and apply to to see the record state in terraform cloud