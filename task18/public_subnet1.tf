module "public_subnet1" {
  source = "./subnet"
  az = "us-east-1a"
  cidr_block = "10.0.1.0/24"
  ivolove_vpc_id = aws_vpc.ivolve_vpc.id
  map_public_ip = true

}

module "public_subnet2" {
  source = "./subnet"
  az = "us-east-1b"
  cidr_block = "10.0.2.0/24"
  ivolove_vpc_id = aws_vpc.ivolve_vpc.id
  map_public_ip = true

}

module "public_route_table" {
  source = "./route_table"
  ivolove_vpc_id = aws_vpc.ivolve_vpc.id
  gateway_id = aws_internet_gateway.igw.id

}

resource "aws_route_table_association" "route_association1" {
  route_table_id = module.public_route_table.id
  subnet_id = module.public_subnet1.id
}

resource "aws_route_table_association" "route_association2" {
  route_table_id = module.public_route_table.id
  subnet_id = module.public_subnet2.id
  
}

