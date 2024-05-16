# allocate elastic ip. this eip will be used for the nat-gateway in the public subnet pub-sub-1-a
resource "aws_eip" "EIP-NAT-GW-A" {
  domain = "vpc"

  tags = merge(
    var.local-tags,
    {
      Name = "NAT-GW-EIP-A"
    }
  )
}


# create nat gateway in public subnet pub-sub-1-a
resource "aws_nat_gateway" "NAT-GW-A" {
  allocation_id = aws_eip.EIP-NAT-GW-A.id
  subnet_id     = var.PUB_SUB_A_ID
  tags = merge(
    var.local-tags,
    {
      Name = "NAT-GW-A"
    }
  )
  # to ensure proper ordering, it is recommended to add an explicit dependency
  depends_on = [var.IGW_ID]
}


# create private route table Pri-RT-A and add route through NAT-GW-A
resource "aws_route_table" "Pri-RT-A" {
  vpc_id = var.VPC_ID

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT-GW-A.id
  }

  tags = merge(
    var.local-tags,
    {
      Name = "Pri-RT-A"
    }
  )
}

# associate private subnet pri-sub-3-a with private route table Pri-RT-A
resource "aws_route_table_association" "pri-sub-a-with-Pri-RT-A" {
  subnet_id      = var.PRI_SUB_A_ID
  route_table_id = aws_route_table.Pri-RT-A.id
}

