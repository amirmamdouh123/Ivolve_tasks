module "public_subnet1" {
  
  source = "./subnet"
  cidr_block = "10.0.0.0/24"
  ivolove_vpc_id = aws_vpc.ivolve-vpc.id
  map_public_ip = true
  az = "us-east-1a"
}

module "public_route_table" {
    source = "./route_table"
    cidr = "0.0.0.0/0"
    ivolove_vpc_id = aws_vpc.ivolve-vpc.id
    gateway_id = aws_internet_gateway.igw.id

}

resource "aws_route_table_association" "route_table_association" {
  subnet_id = module.public_subnet1.id
  route_table_id = module.public_route_table.id
}

resource "aws_eip" "NAT_eip" {
  
}

resource "aws_nat_gateway" "NAT" {
  allocation_id = aws_eip.NAT_eip.id
  subnet_id = module.public_subnet1.id
}



module "nginx_ec2" {
  source = "./ec2_module"
  ami = "ami-05b10e08d247fb927"
  isPublic = true
  key_pair = aws_key_pair.key_pair.key_name
  subnet_id = module.public_subnet1.id
  security_group_ids = [ aws_security_group.web-security-group.id ]
  user_data = base64encode(<<-EOF
            #!/bin/bash
            sudo yum update -y
            sudo yum install -y nginx
            sudo systemctl start nginx
            sudo systemctl enable nginx
            echo "Hello World From Host: $(hostname -I)" > /usr/share/nginx/html/
            EOF
            )
}