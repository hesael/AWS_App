#######################################################################################
# VPC Variables
#######################################################################################

variable "vpc_id" {
    description = "vpc ID"
    type = string
}

#######################################################################################
#  Subnets Variables
#######################################################################################

# Output hardcoded in ./dev-tfvars 
variable "private_app_subnet_az1_cidr" {
    description = "Private Subnet for App servers in Availability Zone 1"
    type = string
}
# Output hardcoded in ./dev-tfvars 
variable "private_app_subnet_az2_cidr" {
    description = "Private Subnet for App servers in Availability Zone 2"
    type = string
}
# Output hardcoded in ./dev-tfvars 
variable "private_data_subnet_az1_cidr" {
    description = "Private Subnet for Database servers in Availability Zone 1"
    type = string
}
# Output hardcoded in ./dev-tfvars 
variable "private_data_subnet_az2_cidr" {
    description = "Private Subnet for Database in Availability Zone 2"
    type = string
}

#######################################################################################
# Others
#######################################################################################

# Output hardcoded in ./dev-tfvars 
variable "public_subnet_az1_cidr" {
    description = "Public Subnet cidr in Availability Zone 1"
    type = string
}
# Output hardcoded in ./dev-tfvars 
variable "public_subnet_az2_cidr" {
    description = "Public Subnet cidr in Availability Zone 2"
    type = string
}
variable "project_name" {
  description = "project name"
  type        = string
}
variable "environment" {
  description = "Environment"
  type        = string
}