# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

This project is going to utilize [Semantic Versioning](https://semver.org/) for its tagging. 

The general format:

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

## Install the Terraform CLI

### Considerations with the Terraform CLI changes

The Terraform CLI installation instructions have changed due to gpg keyring changes. So we needed to refer to the latest install CLI instructions via Terraform documentation and change the scripting for install in `.gitpod.yml`. 

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux distribution

This proejct is built against Ubuntu. 

Please consider checking your Linux distribution and change accordingly to your distribution's needs. 

[How to check OS version in Linux](
https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example:
```sh
$ cat /etc/o

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

### Refactoring into Bash scripts

While fixing the Terraform CLI gpg deprecation issues, we noticed that the installation steps involved considerably more code, so we decided to create a bash script to install the Terraform CLI.

This bash script is located here: [.bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod task file ([.gitpod.yml](.gitpod.yml)) tidy. 
- This will allow us an easier way to debug and execute manually Terraform CLI install
- This will allow better portability for other projects that need to install the Terraform CLI. 

#### Shebang considerations

A Shebang tells the bash script what program should interpret the script. 

ChatGPT recommended that we use this shebang: `#!/usr/bin/env bash`
- for portability for different OS distributions
- will search the user's `PATH` for the best executable

https://en.wikipedia.org/wiki/Shebang_(Unix)

## Execution considerations

When executing the bash script, we can use the `./` shorthand notation to execute the bash script

e.g. `./bin/install_terraform_cli`

If we are using a script in `.gitpod.yml`, we need to point the script to a program to interpret it. 

e.g. `source ./bin/install_terraform_cli`

### Linux permissions considerations

In order to make our bash script executable, we need to change the Linux permissions to the file to be executable at the user mode. 

```sh
chmod u+x ./bin/install_terraform_cli
```

We could also alternatively do:

```sh
chmod 744 ./bin/install_terraform_cli
```

https://en.wikipedia.org/wiki/Chmod

### Gitpod lifecycle (init, before, command)

We need to be careful when usiung `init`, because it won't rerun if we restart an existing workspace. 

https://www.gitpod.io/docs/configure/workspaces/tasks

### Working with env vars

#### env command

We can list out all of the environment variables (env vars) using the `env` command. 

We can filter specific env vars by using `grep`, e.g. `env | grep AWS_`

#### Setting and unsetting env vars

In the terminal, we can set using `export HELLO=WORLD`

In the terminal, we can unset using `unset HELLO`

We can set an env var temporarily when just running a command:

```sh
HELLO='world' ./bin/print_message
```

Within a bash script, we can set an env var without writing `export`, e.g.:

```sh
#!/usr/bin/env bash
HELLO='world'
echo $HELLO
```

#### Printing env vars

We can print an env var using `echo`, e.g. `echo $HELLO`

#### Scoping of env vars

When you open up a new bash terminal in VSCode, it will not be aware of env vars that you set in another terminal. 

If you want env vars to persist across all future bash terminals that are open, you must set env vars in your `.bash_profile`. 

#### Persisting env vars in Gitpod

We can persist env vars in Gitpod by storing them in Gitpod secrets storage. 

```sh
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces. 

You can also set env vars in the `.gitpod.yml` but these can only contain nonsensitive information. 

### AWS CLI installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials are configured correctly by running the following AWS CLI command: 

```sh
aws sts get-caller-identity
```

If it is successful, you should see a JSON payload return that looks like this:

```json
{
    "UserId": "FIDAAGDJG3RCVHK5PWKNP",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"
}
```

We'll need to generate AWS CLI credentials for IAM user in order to use AWS CLI. 

## Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from the Terraform Registry, which is located at [registry.terraform.io](https://registry.terraform.io/).

- **Providers** are interfaces to APIs that will allow you to create resources using Terraform
- **Modules** are a way to make a large amount of Terraform code module, portable, and shareable. 

[random Terraform provider](https://registry.terraform.io/providers/hashicorp/random/)

### Terraform Console

WE can see a list of all the Terraform commands by simply typing `terraform`.

#### Terraform init

At the start of a new terraform project, we will run `terraform init` to download the binaries for the Terraform providers we are using in the project. 

#### Terraform plan

This will generate a changeset showing the state of our infrastructure and what is to be changed. 

We can output this changeset (i.e. plan) to be passed to an apply, but often you can just ignore outputting. 

#### Terraform Apply

`terraform apply`

This will run a plan and pass the changeset to be executed by Terraform. Apply should prompt us for a `yes` or `no`. 

To automatically approve without prompting, provide the `--auto-approve` flag, e.g `terraform apply --auto-approve`

### Terraform Lock Files

`.terraform.lock.hcl` contains the locked versioning for the providers and modules being used with the project. This file **should be** committed to your version control system (VCS), e.g. GitHub. 

### Terraform State Files

`.terraform.tfstate` contains information about the current state of your infrastructure. This file **should not** be committed. This file can contain sensitive data. If you lose this file, you lose knowing the state of your infrastructure. This file **should not** be manually edited. 

### Terraform Directory

`.terraform` directory contains binaries of Terraform providers, among other things. 



