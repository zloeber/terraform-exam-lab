# Terraform Associate Exam Guide

Here is a collection of tasks/notes/labs that may help in studying for Hashicorp's terraform associate exam.

## Requirements

This was all created on a Linux workstation but should function just fine in any bash shell. The generic requirements are;

- terraform binary for your architecture (>=0.12.21)

## Getting Started

As this exam is about terraform as a tool and not any of the specific supported providers, it is cloud agnostic. A good deal of learning and using Terraform will require zero cloud resources. But you will need to have some knowledge of remote state and Terraform Cloud (which conveniently provides remote state). So a few things will need to be setup ahead of time to fully practice for this exam. 

1. GitHub
    - Create a new github organization (free tier) manually with your individual github account (see note below)
    - Setup a new token for the terraform github provider with the ability to manage and delete repositories
    - Optionally, create and setup your own ssh key for github repo access (it makes life much easier)
2. Terraform Cloud
    - Ensure you can login to [the site](https://app.terraform.io)
    - Create and copy a new token for the terraform provider used in the init terraform manifest (under "User Settings" -> "Tokens")

Inside the init folder of this repo is a terraform manifest for kick starting:
- Your own github repo for this terraform study guide.
- A separate Terraform Cloud organization and workspace within it
- A new ssh key pair for integration with your github organization

So rename `init/example.env` to `init/envvars.env` and populate the variables within with your own relevant information for each variable.

Then use terraform to deploy things

These steps have been automated to make life easier;

```bash
# Starting from the base of this repo,
cd ./init
make deps init plan apply
```

You can also migrate your local state into terraform cloud.
- Setup a new backend state manifest.
- Run terraform login to connect to terraform cloud
- Run terraform init again to migrate the local state to terraform cloud 
- Delete the terraform.tfstate* files

see [migrating state to terraform cloud](https://learn.hashicorp.com/terraform/tfc/tfc_migration?utm_source=WEBSITE&utm_medium=WEB_IO&utm_offer=ARTICLE_PAGE&utm_content=DOCS) for more information.

```bash
make output TF_TARGET=backend_state > backend.tf
make login init
rm -f terraform.tfstate*
```

> **NOTE:** Due to a bug in the github provider you will need to create and use a github organization to initialize this project, an individual github account simply will not work. No biggie, the free tier is more than adequate anyway.

## Exam Objectives

| Group | Objective | Link |
|---|---|---|
| 1 	| Understand infrastructure as code (IaC) concepts | []() |
| 1a 	| Explain what IaC is | []() |
| 1b 	| Describe advantages of IaC patterns | []() |
| 2 	| Understand Terraform's purpose (vs other IaC) | []() |
| 2a 	| Explain multi-cloud and provider-agnostic benefits | []() |
| 2b 	| Explain the benefits of state | []() |
| 3 	| Understand Terraform basics | []() |
| 3a 	| Handle Terraform and provider installation and versioning | []() |
| 3b 	| Describe plugin based architecture | []() |
| 3c 	| Demonstrate using multiple providers | []() |
| 3d 	| Describe how Terraform finds and fetches providers | []() |
| 3e 	| Explain when to use and not use provisioners and when to use local-exec or remote-exec | []() |
| 4 	| Use the Terraform CLI (outside of core workflow) | []() |
| 4a 	| Given a scenario: choose when to use terraform fmt to format code | []() |
| 4b 	| Given a scenario: choose when to use terraform taint to taint Terraform resources | []() |
| 4c 	| Given a scenario: choose when to use terraform import to import existing infrastructure into your Terraform state | []() |
| 4d 	| Given a scenario: choose when to use terraform workspace to create workspaces | []() |
| 4e 	| Given a scenario: choose when to use terraform state to view Terraform state | []() |
| 4f 	| Given a scenario: choose when to enable verbose logging and what the outcome/value is | []() |
| 5 	| Interact with Terraform modules | []() |
| 5a 	| Contrast module source options | []() |
| 5b 	| Interact with module inputs and outputs | []() |
| 5c 	| Describe variable scope within modules/child modules | []() |
| 5d 	| Discover modules from the public Terraform Module Registry | []() |
| 5e 	| Defining module version | []() |
| 6 	| Navigate Terraform workflow | []() |
| 6a 	| Describe Terraform workflow ( Write -> Plan -> Create ) | []() |
| 6b 	| Initialize a Terraform working directory (terraform init) | []() |
| 6c 	| Validate a Terraform configuration (terraform validate) | []() |
| 6d 	| Generate and review an execution plan for Terraform (terraform plan) | []() |
| 6e 	| Execute changes to infrastructure with Terraform (terraform apply) | []() |
| 6f 	| Destroy Terraform managed infrastructure (terraform destroy) | []() |
| 7 	| Implement and maintain state | []() |
| 7a 	| Describe default local backend | []() |
| 7b 	| Outline state locking | []() |
| 7c 	| Handle backend authentication methods | []() |
| 7d 	| Describe remote state storage mechanisms and supported standard backends | []() |
| 7e 	| Describe effect of Terraform refresh on state | []() |
| 7f 	| Describe backend block in configuration and best practices for partial configurations | []() |
| 7g 	| Understand secret management in state files | []() |
| 8 	| Read, generate, and modify configuration | []() |
| 8a 	| Demonstrate use of variables and outputs | []() |
| 8b 	| Describe secure secret injection best practice | []() |
| 8c 	| Understand the use of collection and structural types | []() |
| 8d 	| Create and differentiate resource and data configuration | []() |
| 8e 	| Use resource addressing and resource parameters to connect resources together | []() |
| 8f 	| Use Terraform built-in functions to write configuration | []() |
| 8g 	| Configure resource using a dynamic block | []() |
| 8h 	| Describe built-in dependency management (order of execution based) | []() |
| 9 	| Understand Terraform Cloud and Enterprise capabilities | [Terraform Cloud](https://www.terraform.io/docs/cloud/index.html) |
| 9a 	| Describe the benefits of Sentinel, registry, and workspaces | []() |
| 9b 	| Differentiate OSS and TFE workspaces | []() |
| 9c 	| Summarize features of Terraform Cloud | []() |

## SaaS Links

[Terraform Cloud (Enterprise)](https://app.terraform.io/app)

## Study Links

[Study Guide 1](https://adinermie.com/hashicorp-certified-terraform-associate-study-guide/)

[Study Guide 2](https://nedinthecloud.com/2020/04/27/preparing-for-the-hashicorp-terraform-certification/)

[Hashicorp Official Study Guide](https://learn.hashicorp.com/terraform/certification/terraform-associate-study-guide)

[Hashicorp Official Review Guide](https://learn.hashicorp.com/terraform/certification/terraform-associate-review)


## Provider Links

[Terraform Cloud (aka. Terraform Enterprise)](https://www.terraform.io/docs/providers/tfe/index.html)

[Github](https://www.terraform.io/docs/providers/github/index.html)