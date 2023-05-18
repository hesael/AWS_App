# variables for the environment. Can be overide with *.tfvars file

variable "project_name" {
  description = "project name"
  type        = string
}
variable "environment" {
  description = "Environment"
  type        = string
}
variable "vpc_cidr" {
  description = "VCP CIDR"
  type        = string
}
