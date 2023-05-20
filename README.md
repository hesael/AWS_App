# Project Name

This project continues the installation via CI/CD environment. 

## Table of Contents

- [Project Name](#project-name)
  - [Table of Contents](#table-of-contents)
  - [Description](#description)
    - [Prerequisites](#prerequisites)

## Description

This project infrastructure is already deployed under Amazon Free tier account. 

In order to deploy resources, it is recommended to fork a Dev branch for local development. All PR request to Dev will be reviewed before a merge. Then merge to the main after all checks has been validated.

PR approves to the main branch will automatically apply the changes.To speed up development, before submitting PR to Dev, changes can be confirmed prior via terraform terraform plan command.

A terraform plan command is not required, but will take up time to fix any errors as the result will be given from the pipeline, in GitHub actions.

A local check will require API token to terraform cloud. The API token can be provided.

Setup: 
terraform login

### Prerequisites

These will be required, only during initial built. Since all the area already definied in terrform cloud account. If required, these will need to be configured in a .tfvars file in the main root directory:

profile        = "Practice"
project_name   = "Webapp"
environment    = "dev"
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

Also, very impotant. A keypair with name aws
