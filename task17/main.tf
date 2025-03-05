provider "aws" {
  region = "us-east-1"

}


resource "aws_vpc" "ivolve" {
  
    cidr_block = "10.0.0.0/16"
    # id = "vpc-010aea7dc3280a2fe"
    enable_dns_support= true
    enable_dns_hostnames = true


}

resource "aws_internet_gateway" "internet-gateway" {
    vpc_id = aws_vpc.ivolve.id
}


resource "aws_security_group" "public_security" {
    
    vpc_id = aws_vpc.ivolve.id
    ingress        {
            cidr_blocks = ["0.0.0.0/0"]
            from_port = 0
            to_port = 0
            protocol = "tcp"
        }


    

    egress   {
            cidr_blocks = ["0.0.0.0/0"]
            from_port = 0
            to_port = 0
            protocol = "tcp"
        }

    

}