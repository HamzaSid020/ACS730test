resource "aws_key_pair" "assgn1" {
  key_name   = "assgn1"
  public_key = file("assgn1.pub")
}

# Data source for AMI id
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}


# EC2 Instance: Webserver 1 (Public Subnet 1)
resource "aws_instance" "webserver_1" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet_1.id
  security_groups = [aws_security_group.web_sg.id]
  key_name       = aws_key_pair.assgn1.key_name
  tags = {
    Name = "Group1-Webserver1"
  }
  
  # Provision Apache server using a user_data script (optional)
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
              echo "<h1>Welcome to Assignment1! My private IP is $myip</h1><br>Built by Terraform!"  >  /var/www/html/index.html
              sudo wget -O /var/www/html/ilovecats.jpg https://final-dhana-s3.s3.amazonaws.com/images/ilovecats.jpg
              sudo systemctl start httpd
              sudo systemctl enable httpd
              EOF
  
  # Register with ALB target group
  provisioner "local-exec" {
    command = "aws elbv2 register-targets --target-group-arn ${aws_lb_target_group.web_target_group.arn} --targets Id=${self.id}"
  }
}

# EC2 Instance: Webserver 2 (Bastion Host in Public Subnet 2)
resource "aws_instance" "webserver_2" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet_2.id
  security_groups = [aws_security_group.bastion_sg.id]
  key_name       = aws_key_pair.assgn1.key_name
  
  # Provision Apache server using a user_data script (optional)
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
              echo "<h1>Welcome to Assignment1! My private IP is $myip</h1><br>Built by Terraform!"  >  /var/www/html/index.html
              aws s3 cp s3://final-dhana-s3/images/ilovedogs.jpg /var/www/html/ilovedogs.jpg
              sudo systemctl start httpd
              sudo systemctl enable httpd
              EOF
  
  tags = {
    Name = "Group1-BastionHost"
  }
}

# EC2 Instance: Webserver 3 (Public Subnet 3)
resource "aws_instance" "webserver_3" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet_3.id
  security_groups = [aws_security_group.web_sg.id]
  key_name       = aws_key_pair.assgn1.key_name
  tags = {
    Name = "Group1-Webserver3"
  }
  
  # Provision Apache server using a user_data script (optional)
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
              echo "<h1>Welcome to Assignment1! My private IP is $myip</h1><br>Built by Terraform!"  >  /var/www/html/index.html
              aws s3 cp s3://final-dhana-s3/images/ilovedogs.jpg /var/www/html/ilovedogs.jpg
              sudo systemctl start httpd
              sudo systemctl enable httpd
              EOF
  
  # Register with ALB target group
  provisioner "local-exec" {
    command = "aws elbv2 register-targets --target-group-arn ${aws_lb_target_group.web_target_group.arn} --targets Id=${self.id}"
  }
}

# EC2 Instance: Webserver 4 (Public Subnet 4)
resource "aws_instance" "webserver_4" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet_4.id
  security_groups = [aws_security_group.web_sg.id]
  key_name       = aws_key_pair.assgn1.key_name
  tags = {
    Name = "Group1-Webserver4"
  }

  # Register with ALB target group
  provisioner "local-exec" {
    command = "aws elbv2 register-targets --target-group-arn ${aws_lb_target_group.web_target_group.arn} --targets Id=${self.id}"
  }
}

# EC2 Instance: Webserver 5 (Private Subnet 1 with NAT Gateway)
resource "aws_instance" "webserver_5" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet_1.id
  security_groups = [aws_security_group.web_sg.id]
  associate_public_ip_address = false  # No public IP since it's in a private subnet
  key_name       = aws_key_pair.assgn1.key_name
  tags = {
    Name = "Group1-Webserver5"
  }
}

# EC2 Instance: VM 6 (Private Subnet 2)
resource "aws_instance" "vm_6" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet_2.id
  security_groups = [aws_security_group.web_sg.id]
  associate_public_ip_address = false  # No public IP since it's in a private subnet
  key_name       = aws_key_pair.assgn1.key_name
  tags = {
    Name = "Group1-VM6"
  }
}