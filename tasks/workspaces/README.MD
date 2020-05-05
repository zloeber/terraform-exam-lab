# Workspaces (local)

Use this folder to create 3 workspaces for the included terraform manifest (main.tf).

- dev
- stage
- prod

```bash
terraform workspace new dev
terraform init
terraform plan
terraform apply

terraform workspace new stage
terraform init
terraform plan
terraform apply

terraform workspace new prod
terraform init
terraform plan
terraform apply
```

Inspect the terraform.tfstate.d folder to see where each workspace state is stored.

Change back to the default workspace run a terraform init/plan/apply and notice where the state file gets stored.
