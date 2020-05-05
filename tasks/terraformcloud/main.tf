
variable repo_name {}
variable terraform_org {}
variable email {}
variable github_oauth_token {
  default = ""
}

# Configure the GitHub Provider
provider github {
  individual = false
}

provider tfe {
  version = "~> 0.15.0"
}

## Create a key for module downloading
module ssh_key {
  source = "../modules/ssh-key-pair"
  name   = "id_rsa"
  path   = "${path.module}/.local"
}

resource tfe_organization lab {
  name  = "${var.terraform_org}-tf-lab"
  email = var.email
}

resource tfe_workspace lab {
  name         = "exam-lab-init"
  organization = tfe_organization.lab.id
  operations   = false
}

resource tfe_ssh_key lab {
  name         = "exam-lab-ssh-key"
  organization = tfe_organization.lab.name
  key          = module.ssh_key.private_key
}

# resource tfe_oauth_client github {
#   count            = var.github_oauth_token != "" ? 1 : 0
#   organization     = tfe_organization.lab.name
#   api_url          = "https://api.github.com"
#   http_url         = "https://github.com"
#   oauth_token      = var.github_oauth_token
#   service_provider = "github"
# }

resource github_repository terraform_guide {
  name        = var.repo_name
  description = "Terraform Study Guide"
  private     = false
  auto_init   = false
}

resource github_repository terraform_guide_module1 {
  name        = "tf-module-1"
  description = "Terraform Study Guide - Module 1"
  private     = false
  auto_init   = false
}

data template_file backend_state {
  template = file("${path.module}/backend.tmpl")
  vars = {
    terraform_org = tfe_organization.lab.name
    terraform_workspace = tfe_workspace.lab.name
  }
}

output backend_state {
  value = data.template_file.backend_state.rendered
}
