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

