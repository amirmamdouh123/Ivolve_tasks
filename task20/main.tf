provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "ivolve-vpc" {
  
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "my_subnet" {

    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    vpc_id = aws_vpc.my-vpc.id
    tags = {
      Name="my-subnet"
    }
}

resource "aws_instance" "ec2_instance" {

    ami=""

}