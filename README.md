# Project Name

This project continues the installation via CI/CD environment. 

## Table of Contents

- [Project Name](#project-name)
  - [Table of Contents](#table-of-contents)
  - [Description](#description)

## Description

This project infrastructure is already deployed under Amazon Free tier account. 

In order to deploy resources, it is recommended to fork a Dev branch for local development. All PR request to Dev will be reviewed before a merge. Then merge to the main after all checks has been validated.

PR approves to the main branch will automatically apply the changes.To speed up development, before submitting PR to Dev, changes can be confirmed prior via terraform terraform plan command.

A terraform plan command is not required, but will take up time to fix any errors as the result will be given from the pipeline, in GitHub actions.

A local check will require API token to terraform cloud. The API token can be provided.

Setup: 
terraform login







