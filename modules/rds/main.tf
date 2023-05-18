resource "aws_security_group" "rds_security_group" {
  name        = "rds-security-group"
  description = "Security group for RDS"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Update with appropriate IP ranges for access
  }
}

resource "aws_launch_template" "rds_template" {
  name          = "rds-launch-template"
  image_id      = data.aws_ami.server_ami.id
  instance_type = "t2.micro"

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 10 # Update with your desired volume size
    }
  }

  user_data = base64encode(file("${path.module}/userdata/rds.sh"))
}

resource "aws_db_instance" "rds_instance" {
  engine                 = "mysql"
  instance_class         = "db.t2.micro"
  allocated_storage      = 20
  identifier             = "mydatabase"
  db_name                = "mydatabase"
  username               = var.db_admin
  password               = var.db_pass
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.rds_security_group.id]
}
resource "aws_autoscaling_group" "db_server_asg" {
  name             = "app-server-asg"
  desired_capacity = 2
  min_size         = 2
  max_size         = 10
  launch_template {
    id      = aws_launch_template.rds_template.id
    version = "$Latest"
  }
  vpc_zone_identifier = [var.private_app_subnet_az1_id]
}
