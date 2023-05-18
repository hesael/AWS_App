provider "tfe" {
  token = var.TFE_TOKEN
}
provider "aws" {
  region     = "us-west-2"
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY

default_tags {
    tags = {
      "Automation"  = "Terraform"
      "Project"     = "WebApp for barcode data retrieval"
      "Environment" = "Development"
    }
  }
}

