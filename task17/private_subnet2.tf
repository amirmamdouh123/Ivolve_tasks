resource "aws_subnet" "private_subnet2" {
    vpc_id = aws_vpc.ivolve.id
    availability_zone = "us-east-1c"
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = false
    
}

resource "aws_route_table_association" "private_associate2" {
        subnet_id= aws_subnet.private_subnet2.id
        route_table_id = aws_route_table.private_route.id        
}


