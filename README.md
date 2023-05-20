# Project Name

This project continues the installation via CI/CD environment.

## Table of Contents

- [Project Name](#project-name)
  - [Table of Contents](#table-of-contents)
    - [Prerequisites](#prerequisites)
- [This hey needs to be already in AWS.](#this-hey-needs-to-be-already-in-aws)

This project infrastructure is already deployed under an Amazon Free Tier account.

In order to deploy resources, it is recommended to fork a Dev branch for local development. All PR requests to Dev will be reviewed before a merge. Then merge to the main after all checks have been validated.

PR approvals to the main branch will automatically apply the changes. To speed up development, changes can be confirmed prior via the `terraform plan` command.

A `terraform plan` command is not required, but any errors need to be fixed before the changes are applied. The result will be given from the pipeline in GitHub Actions.

A local check will require an API token for Terraform Cloud. The API token can be provided.

Setup:

terraform login

### Prerequisites


### Prerequisites

These will be required only during the initial build since all the areas are already defined in the Terraform Cloud account. If required, these will need to be configured in a `.tfvars` file in the main root directory:

```hcl
profile        = "Practice"
project_name   = "Webapp"
environment    = "dev"
# This hey needs to be already in AWS.
key_name       = "aws_practice_key"
region = "us-east-1"
vpc_cidr       = "10.0.0.0/16"
AWS_ACCESS_KEY = ""
AWS_SECRET_KEY = ""
#public subnets for nat gateways
public_subnet_az1_cidr = "10.0.1.0/24"
public_subnet_az2_cidr = "10.0.2.0/24"

#private subnets for app servers in az1 and az2
private_app_subnet_az1_cidr = "10.0.3.0/24"
private_app_subnet_az2_cidr = "10.0.4.0/24"

#private subnets for database servers in az1 and az2
private_data_subnet_az1_cidr = "10.0.5.0/24"
private_data_subnet_az2_cidr = "10.0.6.0/24"
