######################################################################################
# IAM Instance Profile
######################################################################################
resource "aws_iam_instance_profile" "iam_profile" {
  name = "app-ec2-${var.environment}-ec2-iam-profile"
  role = aws_iam_role.role.name
}

resource "aws_iam_role" "role" {
  name = "app-ec2-${var.environment}-ec2-role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_1" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_3" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_4" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMDirectoryServiceAccess"
}
resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_5" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}




######################################################################################
# Application Load Balancer Security Groups
######################################################################################

# Only Web Ingress Security Group
resource "aws_security_group" "alb_sg" {
  name        = "alb security group"
  description = "enable http/https access on port 80/443"
  vpc_id      = var.vpc_id

  ingress {
    description = "http access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "https access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
  description  = "ICMP"
  from_port    = -1
  to_port      = -1
  protocol     = "icmp"
  cidr_blocks  = ["0.0.0.0/0"]
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb security group"
  }
}

#######################################################################################
# Bastion Security Group
#######################################################################################

resource "aws_security_group" "bastion_sg" {
  name        = "Bastion Server Security Group"
  description = "enable ping and ssh access on port 22"
  vpc_id      = var.vpc_id

  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ping"
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "ping"
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Bastion Server Security Group"
  }
}
#######################################################################################
# App Servers Security Group
#######################################################################################

# create security group for the app server
resource "aws_security_group" "app_server_sg" {
  name        = "web-app-sg"
  description = "enable http/https access on port 80/443 via alb sg"
  vpc_id      = var.vpc_id

  ingress {
    description     = "http access"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  ingress {
    description     = "https access"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description     = "ICMP access"
    from_port       = -1
    to_port         = -1
    protocol        = "icmp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  tags = {
    Name = "app-sg"
  }
}

#######################################################################################
# CI/CD Security Groups
#######################################################################################
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Security group for Jenkins"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 50000
    to_port     = 50000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #access ports for automation
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "jenkings-sg"
  }
}

#######################################################################################
# EC2 Launch Templates
#######################################################################################

# App Server
resource "aws_launch_template" "app_server_launch_template" {
  name_prefix            = "app-server-launch-template"
  instance_type          = "t2.micro"
  image_id               = data.aws_ami.server_ami.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.app_server_sg.id,aws_security_group.alb_sg, aws_security_group.bastion_sg.id]

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 10
    }
  }
  user_data = base64encode(file("${path.module}/userdata/userdata.sh"))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "dev-app-node"
    }
  }
}

# Bastion Public Eip Asociation to bastion host
resource "aws_eip" "bastion_eip" {
  vpc = true

  tags = {
    Name = "bastion az1 eip"
  }
}
resource "aws_launch_template" "bastion_launch_template" {
  name_prefix            = "app-server-launch-template"
  instance_type          = "t2.micro"
  image_id               = data.aws_ami.server_ami.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.app_server_sg.id, aws_security_group.bastion_sg.id]

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 10
    }
  }
  user_data = base64encode(file("${path.module}/userdata/bastion.sh"))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "dev-app-node"
    }
  }
}
resource "aws_instance" "bastion_node" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.server_ami.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  subnet_id              = var.public_subnet_az1_id
  user_data              = base64encode(file("${path.module}/userdata/bastion.sh"))

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "dev-bastion"
  }
}

# Associate EIP with bastion host
resource "aws_eip_association" "bastion_eip_association" {
  instance_id   = aws_instance.bastion_node.id
  allocation_id = aws_eip.bastion_eip.id
}


#######################################################################################
# Application Load Balancer And Auto Scaling Config
#######################################################################################
resource "aws_lb" "app_server" {
  name               = "app-server-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [var.private_app_subnet_az1_id, var.private_app_subnet_az2_id]

  enable_deletion_protection = false

  tags = {
    value = var.environment
  }
}

# Create Target group
resource "aws_lb_target_group" "app_server" {
  name     = "app-server-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

# Configure ALB Listerner

resource "aws_lb_listener" "app_server" {
  load_balancer_arn = aws_lb.app_server.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_server.arn
  }
}
resource "aws_autoscaling_group" "app_server_asg" {
  name             = "app-server-asg"
  desired_capacity = 2
  min_size         = 2
  max_size         = 10

  launch_template {
    id      = aws_launch_template.app_server_launch_template.id
    version = "$Latest"
  }

  vpc_zone_identifier = [var.private_app_subnet_az1_id]
}

#
#######################################################################################
# All Open Security Group
#######################################################################################
resource "aws_security_group" "all_open" {
  name        = "all-open-sg"
  description = "To test apps in public subnet"
  vpc_id      = var.vpc_id
  ingress {
    description = "all tcp ports"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    description     = "ICMP access"
    from_port       = -1
    to_port         = -1
    protocol        = "icmp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "all-open-sg"
  }
}
######################################################################################
# Public node for Outside Testing
#######################################################################################

# Test Node in Public Subnet
resource "aws_instance" "app_test" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.server_ami.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.all_open.id]

  subnet_id = var.public_subnet_az1_id
  user_data = base64encode(file("${path.module}/userdata/userdata.sh"))
  root_block_device {
    volume_size = 10
  }
  associate_public_ip_address = true
  tags = {
    Name = "dev-test-node"
  }
}
