# allocate elastic ip. this eip will be used for the nat-gateway in the public subnet pub-sub-1-a
resource "aws_eip" "EIP-NAT-GW-B" {
  domain = "vpc"

  tags = merge(
    var.local-tags,
    {
      Name = "NAT-GW-EIP-B"
    }
  )
}


# create nat gateway in public subnet pub-sub-1-a
resource "aws_nat_gateway" "NAT-GW-B" {
  allocation_id = aws_eip.EIP-NAT-GW-B.id
  subnet_id     = var.PUB_SUB_B_ID
  tags = merge(
    var.local-tags,
    {
      Name = "NAT-GW-B"
    }
  )
  # to ensure proper ordering, it is recommended to add an explicit dependency
  depends_on = [var.IGW_ID]
}


# create private route table Pri-RT-B and add route through NAT-GW-A
resource "aws_route_table" "Pri-RT-B" {
  vpc_id = var.VPC_ID

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT-GW-B.id
  }

  tags = merge(
    var.local-tags,
    {
      Name = "Pri-RT-B"
    }
  )
}


resource "aws_route_table_association" "pri-sub-b-with-Pri-RT-B" {
  subnet_id      = var.PRI_SUB_B_ID
  route_table_id = aws_route_table.Pri-RT-B.id
}

