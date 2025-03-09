provider "aws" {
  region = "us-east-1"
}


resource "aws_vpc" "ivolve_vpc" {
    cidr_block = "10.0.0.0/16"
    
}


resource "tls_private_key" "my-private-key" {
        rsa_bits = 4096
        algorithm = "RSA"
}

resource "aws_key_pair" "ivolve_key_pair" {
  key_name= "ivolve_key_pair"
  public_key = tls_private_key.my-private-key.public_key_openssh
}

resource "local_file" "private_key" {
  filename = "ivolve-key.pem"
  content = tls_private_key.my-private-key.private_key_pem
}

resource "aws_internet_gateway" "igw" {
  vpc_id= aws_vpc.ivolve_vpc.id

}


resource "aws_security_group" "public_security" {
    
    vpc_id = aws_vpc.ivolve_vpc.id
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