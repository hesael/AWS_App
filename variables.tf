#######################################################################################
#  AWS Login Variables
#######################################################################################

variable "AWS_ACCESS_KEY" {
  description = "AWS Access Key"
  type        = string
}
variable "AWS_SECRET_KEY" {
  description = "AWS Secret Key"
  type        = string
}
#######################################################################################
#  VPC Variables
#######################################################################################

variable "environment" {
  description = "Environment"
  type        = string
}
variable "region" {
  description = "Region"
  type        = string
}
variable "profile" {
  description = "Profile"
  type        = string
}
variable "project_name" {
  description = "Project Name"
  type        = string
}
variable "key_name" {
  description = "Project Name"
  type        = string
}
variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}
#######################################################################################
#  MySQL Variables
#######################################################################################

variable "db_admin" {
  description = "MySQL db_admin"
  type        = string
}
variable "db_pass" {
  description = "MySQL Db Pass"
  type        = string
}

#######################################################################################
#  Subnets Variables
#######################################################################################

# Output hardcoded in ./dev-tfvars 
variable "private_app_subnet_az1_cidr" {
  description = "Private Subnet for App servers in Availability Zone 1"
  type        = string
}
# Output hardcoded in ./dev-tfvars 
variable "private_app_subnet_az2_cidr" {
  description = "Private Subnet for App servers in Availability Zone 2"
  type        = string
}
# Output hardcoded in ./dev-tfvars 
variable "private_data_subnet_az1_cidr" {
  description = "Private Subnet for Database servers in Availability Zone 1"
  type        = string
}
# Output hardcoded in ./dev-tfvars 
variable "private_data_subnet_az2_cidr" {
  description = "Private Subnet for Database in Availability Zone 2"
  type        = string
}

# Output hardcoded in ./dev-tfvars 
variable "public_subnet_az1_cidr" {
  description = "Public Subnet cidr in Availability Zone 1"
  type        = string
}
# Output hardcoded in ./dev-tfvars 
variable "public_subnet_az2_cidr" {
  description = "Public Subnet cidr in Availability Zone 2"
  type        = string
}
