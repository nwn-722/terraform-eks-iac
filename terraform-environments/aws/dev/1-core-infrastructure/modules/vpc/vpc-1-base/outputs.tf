
output "VPC_ID" {
  value = aws_vpc.vpc.id
}

output "PUBLIC_SUBNET_A_ID" {
  value = aws_subnet.public-subnet-a.id
}

output "PUBLIC_SUBNET_B_ID" {
  value = aws_subnet.public-subnet-b.id
}

output "PUBLIC_SUBNET_C_ID" {
  value = aws_subnet.public-subnet-c.id
}

output "PRIVATE_SUBNET_A_ID" {
  value = aws_subnet.private-subnet-a.id
}

output "PRIVATE_SUBNET_B_ID" {
  value = aws_subnet.private-subnet-b.id
}

output "PRIVATE_SUBNET_C_ID" {
  value = aws_subnet.private-subnet-c.id
}

