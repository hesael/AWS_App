#######################################################################################
# Security Group Variables For RDS Instances
#######################################################################################

variable "vpc_id" {
  description = "vpc ID"
  type        = string
}
variable "environment" {
  description = "Environment"
  type        = string
}
variable "db_admin" {
  description = "MySQL admin user"
  type        = string
}
variable "db_pass" {
  description = "MySQL Password"
  type        = string
}
variable "private_app_subnet_az1_id" {
  description = "AZ for the RDS"
  type        = string
}
