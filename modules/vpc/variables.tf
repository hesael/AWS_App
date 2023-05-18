# variables for the environment. Can be overide with *.tfvars file
variable "REGION" {
  description = "default region"
  type        = string
}
variable "project_name" {
  description = "project name"
  type        = string
}
variable "environment" {
  description = "Environment"
  type        = string
}
# variables for the vpc

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}
