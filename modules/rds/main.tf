
#######################################################################################
# My SQL RDS Security Group
#######################################################################################

resource "aws_security_group" "database_security_group" {
  name        = "db-sg"
  description = "enable mysql/aurora access on port 3306"
  vpc_id      = var.vpc_id

  ingress {
    description     = "mysql/aurora access"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description     = "custom access"
    from_port       = 33062
    to_port         = 33062
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db-sg"
  }
}

resource "aws_db_subnet_group" "rds_subnet" {
  name       = "db-subnet-group"
  subnet_ids = [var.private_data_subnet_az1_id,var.private_data_subnet_az2_id]
}

resource "aws_db_instance" "myqsl_rds_instance" {
  engine                 = "mysql"
  instance_class         = "db.t2.micro"
  allocated_storage      = 20
  identifier             = "mydatabase"
  db_name                = "mydatabase"
  username               = var.db_admin
  password               = var.db_pass
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.database_security_group.id]
  db_subnet_group_name = aws_db_subnet_group.rds_subnet.name
}