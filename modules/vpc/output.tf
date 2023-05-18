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

# export the vpc id
output "vpc_id" {
  value = aws_vpc.vpc.id
}









