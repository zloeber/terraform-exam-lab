# Terraform Cloud

As this exam is about terraform as a tool and not any of the specific supported providers, it is cloud agnostic. Because of this, a good deal of learning and using Terraform will require zero cloud resources. But you will need to have knowledge of remote state and Terraform Cloud (which conveniently provides remote state). This task shows how you can use Terraform itself to setup these resources.

## Task - Configure Terraform Cloud

These elements are created by following this task.

1. GitHub
    - Create a new github organization (free tier, see note below) manually with your individual github account
    - Setup a new token for the terraform github provider with the ability to manage and delete repositories
    - Optionally, create and setup your own ssh key for github repo access (it makes life much easier)
2. Terraform Cloud
    - First create an account if you don't already have one on [Terraform Cloud](https://app.terraform.io)
    - Then in Terraform Cloud, create a new token under "User Settings" -> "Tokens".
    - Save the token as it will be used in the terraform manifest for the terraform enterprise provider (which also works for terraform cloud)

Inside this folder is a terraform manifest for kick starting:
- Your own github repo for this terraform study guide.
- A separate Terraform Cloud organization and workspace within it.
- A new ssh key pair for integration with your github organization.

To use this manifest rename `init/example.env` to `init/envvars.env` then populate the variables within it.

This file should contain:

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
make deps init plan apply
```

## Task - Migrate Remote State

Once you have done the first initialization, you can then migrate your local state for this manifest into terraform cloud! 

The steps to do this are;

1. Setup a new backend state manifest.
2. Run terraform login to connect to terraform cloud
3. Run terraform init again to migrate the local state to terraform cloud
4. Delete the terraform.tfstate* files

See [migrating state to terraform cloud](https://learn.hashicorp.com/terraform/tfc/tfc_migration?utm_source=WEBSITE&utm_medium=WEB_IO&utm_offer=ARTICLE_PAGE&utm_content=DOCS) for more information on this process.

Here is the simplified version of accomplishing this task (though I recommend manually running through this exercise to understand the workflow for migrating state into Terraform Cloud)

```bash
make output TF_TARGET=backend_state > backend.tf
make login init
rm -f terraform.tfstate*
```