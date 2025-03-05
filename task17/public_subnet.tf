resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.ivolve.id
    availability_zone = "us-east-1a"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.ivolve.id
  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet-gateway.id
    }

}

resource "aws_route_table_association" "public_associate" {
        subnet_id= aws_subnet.public_subnet.id
        route_table_id = aws_route_table.public_route.id        
}


resource "aws_eip" "nat_IP" {
  
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_IP.id
  subnet_id = aws_subnet.public_subnet.id
}


resource "aws_instance" "ec2" {
  
  ami = "ami-05b10e08d247fb927"
  vpc_security_group_ids= [ aws_security_group.public_security.id ]
  subnet_id = aws_subnet.public_subnet.id

  instance_type = "t2.micro"

  key_name = aws_key_pair.my-key-pair.key_name

  user_data = base64encode(<<-EOF
            #!/bin/bash
            sudo yum update -y
            sudo yum install -y httpd
            sudo systemctl start httpd
            sudo systemctl enable httpd
            sudo yum openshh-server -y
            sudo systemctl enable sshd
            echo "Hello World From Host: $(hostname -I)" > /var/www/html/index.html
            EOF
            )

}
# output "rds_endpoint" {
#   value = aws_instance.ec2.id
# }

resource "local_file" "ec2_id" {
  filename = "ec2_id.txt"
  content = aws_instance.ec2.id
  
}