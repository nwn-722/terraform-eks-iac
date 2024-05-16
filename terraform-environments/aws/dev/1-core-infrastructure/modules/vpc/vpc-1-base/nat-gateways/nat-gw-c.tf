# allocate elastic ip. this eip will be used for the nat-gateway in the public subnet pub-sub-1-a
resource "aws_eip" "EIP-NAT-GW-C" {
  domain = "vpc"

  tags = merge(
    var.local-tags,
    {
      Name = "NAT-GW-EIP-C"
    }
  )
}


# create nat gateway in public subnet pub-sub-1-a
resource "aws_nat_gateway" "NAT-GW-C" {
  allocation_id = aws_eip.EIP-NAT-GW-C.id
  subnet_id     = var.PUB_SUB_C_ID
  tags = merge(
    var.local-tags,
    {
      Name = "NAT-GW-C"
    }
  )
  # to ensure proper ordering, it is recommended to add an explicit dependency
  depends_on = [var.IGW_ID]
}


# create private route table Pri-RT-C and add route through NAT-GW-C
resource "aws_route_table" "Pri-RT-C" {
  vpc_id = var.VPC_ID

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT-GW-C.id
  }

  tags = merge(
    var.local-tags,
    {
      Name = "Pri-RT-C"
    }
  )
}


resource "aws_route_table_association" "pri-sub-c-with-Pri-RT-C" {
  subnet_id      = var.PRI_SUB_C_ID
  route_table_id = aws_route_table.Pri-RT-C.id
}