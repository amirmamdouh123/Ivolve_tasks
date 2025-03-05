resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.ivolve.id
    availability_zone = "us-east-1b"
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = false
    
}

resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.ivolve.id
  route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat.id
    }
   
}

resource "aws_route_table_association" "private_associate" {
        subnet_id= aws_subnet.private_subnet.id
        route_table_id = aws_route_table.private_route.id        
}


resource "aws_db_instance" "my_rds" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine              = "mysql"
  engine_version      = "8.0"
  instance_class      = "db.t3.micro"
  db_name             = "mydatabase"
  username           = "admin"
  password           = "mypassword" 
  parameter_group_name = "default.mysql8.0"
  publicly_accessible  = true
  skip_final_snapshot = true
  vpc_security_group_ids = [aws_security_group.public_security.id]
  
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
}

resource "aws_db_subnet_group" "db_subnet_group" {
  subnet_ids= [aws_subnet.private_subnet.id , aws_subnet.private_subnet2.id     ] 
}

output "rds_endpoint" {
  value = aws_db_instance.my_rds.endpoint
}