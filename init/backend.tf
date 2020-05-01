terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "zloeber-tf-lab"

    workspaces {
      name = "exam-lab-init"
    }
  }
}
