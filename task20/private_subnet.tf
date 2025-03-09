module "private_subnet1" {
  source = "./subnet"
  cidr_block = "10.0.1.0/24"
  ivolove_vpc_id = aws_vpc.ivolve-vpc.id
  map_public_ip = false
  az = "us-east-1b"
}


module "private_route_table" {
    source = "./route_table"
    cidr = "0.0.0.0/0"
    ivolove_vpc_id = aws_vpc.ivolve-vpc.id
    gateway_id = aws_nat_gateway.NAT.id

}

resource "aws_route_table_association" "private_route_table_association" {

  subnet_id = module.private_route_table.id
  route_table_id = module.private_route_table.id

}


module "http_ec2" {
  source = "./ec2_module"
  ami = "ami-05b10e08d247fb927"
  isPublic = false
  key_pair = aws_key_pair.key_pair.key_name
  subnet_id = module.private_subnet1.id
  security_group_ids = [ aws_security_group.web-security-group.id ]
  user_data = base64encode(<<-EOF
            #!/bin/bash
            sudo yum update -y
            sudo yum install -y httpd
            sudo systemctl start httpd
            sudo systemctl enable httpd
            echo "Hello World From Host: $(hostname -I)" > /var/www/html/index.html
            EOF
            )
}



