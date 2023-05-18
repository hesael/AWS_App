
#######################################################################################
# VPC Variables Exports
#######################################################################################
# export the vpc id
output "vpc_id" {
  value = var.vpc_id
}
#######################################################################################
#  Private Subnets Variable Exports
#######################################################################################

# export the private subnet cidr for app servers in az1
output "private_app_subnet_az1_cidr" {
  value = var.private_app_subnet_az1_cidr
}
# export the private subnet cidr for app servers in az2
output "private_app_subnet_az2_cidr" {
  value = var.private_app_subnet_az2_cidr
}
# export the private subnet cidr for database servers in az1
output "private_data_subnet_az1_cidr" {
  value = var.private_data_subnet_az1_cidr
}
# export the private subnet cidr for database servers in az2
output "private_data_subnet_az2_cidr" {
  value = var.private_data_subnet_az2_cidr
}
#######################################################################################
#  Public Subnets Variable Exports
#######################################################################################

output "public_subnet_az1_cidr" {
  value = var.public_subnet_az1_cidr
}

output "public_subnet_az2_cidr" {
  value = var.public_subnet_az2_cidr
}

#######################################################################################
#  Others
#######################################################################################

# export the first availability zone
output "availability_zone_1" {
  value = data.aws_availability_zones.available_zones.names[0]
}
# export the second availability zone
output "availability_zone_2" {
  value = data.aws_availability_zones.available_zones.names[1]
}
#public subnet output (For Bastion Use)
output "public_subnet_az1_id" {
  value = aws_subnet.public_subnet_az1.id
}
# export the private subnet id for app servers in az1
output "private_app_subnet_az1_id" {
  value = aws_subnet.private_app_subnet_az1.id
}
# export the private subnet id for app servers in az2
output "private_app_subnet_az2_id" {
  value = aws_subnet.private_app_subnet_az2.id
}
# export the private subnet id for database servers in az1
output "private_data_subnet_az1_id" {
  value = aws_subnet.private_data_subnet_az1.id
}
# export the private subnet id for database servers in az2
output "private_data_subnet_az2_id" {
  value = aws_subnet.private_data_subnet_az2.id
}
# export the region
output "REGION" {
  value = var.region
}
# export the project name
output "project_name" {
  value = var.project_name
}
# export the environment
output "environment" {
  value = var.environment
}