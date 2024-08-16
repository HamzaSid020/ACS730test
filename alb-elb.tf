# Security Group for the ALB
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
    Name = "Group1-ALB-SG"
  }
}

# Application Load Balancer (ALB)
resource "aws_lb" "web_alb" {
  name               = "Group1-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [
    aws_subnet.public_subnet_1.id, 
    aws_subnet.public_subnet_2.id,
    aws_subnet.public_subnet_3.id,
    aws_subnet.public_subnet_4.id
  ]

  enable_deletion_protection = false

  tags = {
    Name = "Group1-ALB"
  }
}

# Target Group for the ALB
resource "aws_lb_target_group" "web_target_group" {
  name     = "Group1-Target-Group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.prod_vpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "Group1-Target-Group"
  }
}

# ALB Listener for HTTP Traffic
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_target_group.arn
  }
}