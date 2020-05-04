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

So rename `init/example.env` to `init/envvars.env` and populate the variables within with your own relevant information for each variable. This file should contain:

```bash
## Rename this to envvars.env after adding your token. 
# https://www.terraform.io/docs/providers/github/index.html
GITHUB_TOKEN=
GITHUB_ORGANIZATION=
TFE_TOKEN=
TF_VAR_repo_name=terraform-study-guide
TF_VAR_terraform_org=
TF_VAR_email=
```

> **NOTE:** Due to a bug in the github provider you will need to create and use a github organization to initialize this project, an individual github account simply will not work. No biggie, the free tier is more than adequate anyway.

Then use terraform to deploy things. These steps have been automated to make life easier.

```bash
# Starting from the base of this repo,
cd ./init
make deps init plan apply
```

## Setup Remote State

Once you have done the first initialization, you can then migrate your local state into terraform cloud. The steps to do this are;

1. Setup a new backend state manifest.
2. Run terraform login to connect to terraform cloud
3. Run terraform init again to migrate the local state to terraform cloud
4. Delete the terraform.tfstate* files

See [migrating state to terraform cloud](https://learn.hashicorp.com/terraform/tfc/tfc_migration?utm_source=WEBSITE&utm_medium=WEB_IO&utm_offer=ARTICLE_PAGE&utm_content=DOCS) for more information on this process.

Here is the simplified version of setting this up for this repo.

```bash
make output TF_TARGET=backend_state > backend.tf
make login init
rm -f terraform.tfstate*
```

## Study Links

[Study Guide 1](https://adinermie.com/hashicorp-certified-terraform-associate-study-guide/)

[Study Guide 2](https://nedinthecloud.com/2020/04/27/preparing-for-the-hashicorp-terraform-certification/)

[Udemy Practice Exams ($$)](https://www.udemy.com/course/terraform-associate-practice-exam/)

[Hashicorp Official Study Guide](https://learn.hashicorp.com/terraform/certification/terraform-associate-study-guide)

[Hashicorp Official Review Guide](https://learn.hashicorp.com/terraform/certification/terraform-associate-review)

## SaaS Links

[Terraform Cloud (Enterprise)](https://app.terraform.io/app)

## Provider Links

The following terraform providers were used to construct resources.

[Terraform Cloud (aka. Terraform Enterprise)](https://www.terraform.io/docs/providers/tfe/index.html)

[Github](https://www.terraform.io/docs/providers/github/index.html)