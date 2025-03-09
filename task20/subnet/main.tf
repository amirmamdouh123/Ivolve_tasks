resource "aws_subnet" "subnet" {
  vpc_id = var.ivolove_vpc_id
  cidr_block = var.cidr_block
  availability_zone = var.az
  map_public_ip_on_launch = var.map_public_ip

}




# resource "aws_subnet" "subnet" {
#   vpc_id = vars.ivolove_vpc_id
#   cidr_block = "10.0.1.0/24"
#   availability_zone = "us-east-1a"
#   map_public_ip_on_launch = true
  
# }
