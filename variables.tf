variable "environment" {
  description = "Environment"
  type        = string
}
variable "profile" {
  description = "Environment"
  type        = string
}
variable "project_name" {
  description = "project name"
  type        = string
}
variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}
variable "AWS_ACCESS_KEY" {
  description = "AWS Access Key"
  type        = string
}
variable "AWS_SECRET_KEY" {
  description = "AWS Secret Key"
  type        = string
}
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

#######################################################################################
# Others
#######################################################################################

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
