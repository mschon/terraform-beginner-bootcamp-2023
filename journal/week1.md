# Terraform Beginner Bootcamp 2023 - Week 1

## Fixing Tags

[How to delete local and remote tags from Git](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/)

```sh
git tag -d tagName                # delete locally
git push --delete origin tagName  # delete tag from origin
```

Then identify the commit that you want to retag and check out the commit using its SHA.

```sh
git checkout sha    # check out commit (in detached HEAD state)
git tag newTagName  # retag
git push --tags     # push tag to origin
git checkout main   # return back to main branch
```

You can also use the following instead:

```sh
git tag newTagName sha
git push --tags
```

## Root Module Structure

Our root module structure is as follows:

```
PROJECT_ROOT
│
├── main.tf                 # everything else
├── variables.tf            # stores the structure of input variables
├── terraform.tfvars        # variables we want to load into our terraform project
├── providers.tf            # required providers and their configuration
├── outputs.tf              # stores our outputs
└── README.md               # required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables

### Terraform Cloud Variables

In Terraform, we can set two kind of variables:
- Enviroment Variables - those you would set in your bash terminal, e.g. AWS credentials
- Terraform Variables - those that you would normally set in your tfvars file

We can set Terraform Cloud variables to be sensitive so they are not shown visibly in the UI. 

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag

We can use the `-var` flag to set an input variable or override a variable in the tfvars file, e.g. `terraform -var user_uuid="my-user_id"`

### var-file flag

- TODO: research and document this flag

https://developer.hashicorp.com/terraform/language/values/variables#variable-definitions-tfvars-files

### terraform.tfvars

The default file to load in Terraform variables in bulk. 

### auto.tfvars

- TODO: research and document this functionality for terraform cloud

### order of terraform variables

- TODO: research and document which terraform variables takes precedence.

https://developer.hashicorp.com/terraform/language/values/variables#variable-definition-precedence

## Dealing with configuration drift

### What happens if we lose our state file?

If you lose your state file, you most likely have to tear down your cloud infrastructure manually. You can use `tf import` but it won't work for all cloud resources. You need to check the provider's documentation in the Terraform Registry to see if the resource supports import. 

### Fix missing resources with Terraform Import

`tf import aws_s3_bucket.bucket bucket-name` 

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix manual configuration

Scenario: If someone deletes or modifies cloud resources manually through clickops (i.e. without using terraform).

If we run `tf plan`, we can attempt to put our infrastructure back into the expected state. 

## Fix using Terraform Refresh

```sh
tf apply -refresh-only -auto-approve
```

## Terraform modules

### Terraform Module Structure

It is recommended to place modules in a `modules` directory when locally developing modules, but you can name it whatever you like. 

### Passing Input Variables

We can pass input variables to our module. 

The module must declare these Terraform variables in its own `variables.tf`. 

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

### Modules sources

Using the source, we can import the module from various plages, e.g. 
- locally
- GitHub
- Terraform Registry

[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Considerations when using ChatGPT to write Terraform

LLMs such as ChatGPT may not be trained on the latest documentation or information about Terraform. 

It may produce outdated examples that could be deprecated. This often affects Terraform providers which can change at a more frequent pace than Terraform itself. 

## Working with Files in Terraform

### fileexists function

[`fileexists()`](https://developer.hashicorp.com/terraform/language/functions/fileexists) is a built-in Terraform function to check for the existence of a file. 

### filemd5 function

[`filemd5()`](https://developer.hashicorp.com/terraform/language/functions/filemd5) is a built-in Terraform function that generates an MD5 hash from a file. 

### Path Variable

In Terraform, there is a special variable called `path` that allows us to reference local paths. 
- `path.module` - get the path for the current module
- `path.root` - get the path for the root module

[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

```
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = ${path.root}/public/index.html
}
```

## Terraform Locals

[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)

Locals allow us to define local variables. 

This can be useful when we need to transform data into another format and have it referenced as a variable. 

```tf
locals {
    s3_origin_id = "MyS3Origin"
}
```

## Terraform Data Sources

[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

This allows us to source data from cloud resources. 

This is useful when we want to reference cloud resources without importing them. 

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```

## Working with JSON

We use the [`jsonencode()` function](https://developer.hashicorp.com/terraform/language/functions/jsonencode) to create the S3 bucket policy inline in the HCL. 

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```

## Changing the lifecycle of resources

[Meta-Arguments lifecyle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

## Terraform Data

[`terraform_data`](https://developer.hashicorp.com/terraform/language/resources/terraform-data)

> Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in `replace_triggered_by`. You can use `terraform_data`'s behavior of planning an action each time `input` changes to indirectly use a plain value to trigger replacement.

## Provisioners

[Provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax) allow you to execute commands, e.g. an AWS CLI command, on compute instances. 

They are not recommended for use by HashiCorp because configuration management tools like Ansible are a better fit, but the functionality exists. 

Provisioners are 
https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax#provisioners-are-a-last-resort

### local exec

[local-exec](https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec) executes a command on the machine running the Terraform commands, e.g. `tf plan`, `tf apply`, etc. 

Example usage:
```tf
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
  }
}
```

### remote exec

[remote-exec](https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec) executes a command on the machine which you target. You need to provide credentials, such as ssh to access the machine. 

Example usage:
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

## for expressions

[`for` expressions](https://developer.hashicorp.com/terraform/language/expressions/for) allow us to enumerate over complex data types. 

Example:
```
[for s in var.list : upper(s)]
```

This is mostly useful when you are creating multiples of a cloud resource and you want to reduce the amount of repetitive Terraform code. 

