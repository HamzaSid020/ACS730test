# Bastion Security Group
resource "aws_security_group" "bastion_sg" {
  vpc_id      = aws_vpc.prod_vpc.id
  description = "Allow SSH from the world"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Group2-Bastion-SG"
  }
}

# Web Server Security Group
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.prod_vpc.id
  description = "Allow HTTP from ALB and SSH from Bastion and Ansible Host"

  # Allow HTTP traffic from ALB SG
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }
  # Allow SSH from Bastion SG
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }
  # To Allow SSH from Ansible, hardcoding it from the Cloud9 instance public IP  
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks = ["3.238.200.186/32"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Group2-Web-SG"
  }
}

# ALB Security Group
resource "aws_security_group" "alb_sg" {
  vpc_id = aws_vpc.prod_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Group2-ALB-SG"
  }
}

# Security Group for Private Instances (Restricting access only from Bastion Host)
resource "aws_security_group" "private_instance_sg" {
  vpc_id      = aws_vpc.prod_vpc.id
  description = "Allow SSH only from Bastion Host"

  ingress {
    description = "Allow SSH from Bastion Host"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Group2-Private-Instance-SG"
  }
}
