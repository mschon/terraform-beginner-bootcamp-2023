# Terraform Beginner Bootcamp 2023 - Week 1

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
