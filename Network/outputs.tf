output "vpc_id" {
  value = aws_vpc.prod_vpc.id
}

output "public_subnet_1" {
  value = aws_subnet.public_subnet_1.id
}

output "public_subnet_2" {
  value = aws_subnet.public_subnet_2.id
}

output "public_subnet_3" {
  value = aws_subnet.public_subnet_3.id
}

output "public_subnet_4" {
  value = aws_subnet.public_subnet_4.id
}

output "private_subnet_1" {
  value = aws_subnet.private_subnet_1.id
}

output "private_subnet_2" {
  value = aws_subnet.private_subnet_2.id
}

output "web_sg" {
    value      = aws_security_group.web_sg.id
}

output "alb_sg" {
    value      = aws_security_group.alb_sg.id
}

output "bastion_sg" {
    value  = aws_security_group.bastion_sg.id
}

output "private_instance_sg" {
    value  = aws_security_group.private_instance_sg.id
}
