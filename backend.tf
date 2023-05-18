terraform {
  required_version = "~> 1.4.6"

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "ProjectQ2"
    workspaces {
      name = "Barcode-Reader"
    }
  }
}