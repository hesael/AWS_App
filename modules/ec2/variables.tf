#######################################################################################
# Security Group Variables For EC2 Instances
#######################################################################################

variable "public_subnet_az1_id" {
  description = "Public Subnet in Availability Zone 1"
  type        = string
}
variable "private_app_subnet_az1_id" {
  description = "Private Subnet in Availability Zone 1"
  type        = string
}
variable "private_app_subnet_az2_id" {
  description = "Private Subnet in Availability Zone 2"
  type        = string
}
variable "private_data_subnet_az1_id" {
  description = "Private Subnet in Availability Zone 1"
  type        = string
}
variable "private_data_subnet_az2_id" {
  description = "Private Subnet in Availability Zone 1"
  type        = string
}
variable "vpc_id" {
  description = "vpc ID"
  type        = string
}
variable "environment" {
  description = "Environment"
  type        = string
}
