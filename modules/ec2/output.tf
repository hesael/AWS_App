
#######################################################################################
# Security Groups Variables Ouput
#######################################################################################

output "vpc_id" {
  value = var.vpc_id
}
output "environment" {
  value = var.environment
}

# # export the first availability zone
# output "availability_zone_1" {
#   value = data.aws_availability_zones.available_zones.names[0]
# }
# # export the second availability zone
# output "availability_zone_2" {
#   value = data.aws_availability_zones.available_zones.names[1]
# }
# #public subnet output (For Bastion Use)
# output "public_subnet_az1_id" {
#   value = aws_subnet.public_subnet_az1.id 
# }
# # export the private subnet id for app servers in az1
# output "private_app_subnet_az1_id" {
#   value = aws_subnet.private_app_subnet_az1.id
# }
# # export the private subnet id for app servers in az2
# output "private_app_subnet_az2_id" {
#   value = aws_subnet.private_app_subnet_az2.id
# }
# # export the private subnet id for database servers in az1
# output "private_data_subnet_az1_id" {
#   value = aws_subnet.private_data_subnet_az1.id
# }
# # export the private subnet id for database servers in az2
# output "private_data_subnet_az2_id" {
#   value = aws_subnet.private_data_subnet_az2.id
# }


