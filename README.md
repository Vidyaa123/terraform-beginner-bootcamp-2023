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



