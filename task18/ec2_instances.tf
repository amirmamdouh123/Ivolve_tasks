module "nginx_ec21" {
  source = "./ec2_module"
  ami = "ami-05b10e08d247fb927"
  isPublic = true
  key_pair = aws_key_pair.ivolve_key_pair.key_name
  subnet_id = module.public_subnet1.id
  security_group_ids = [ aws_security_group.public_security.id ]
  user_data = <<-EOF
            #!/bin/bash
            sudo yum update -y
            sudo yum install -y nginx
            sudo systemctl start nginx
            sudo systemctl enable nginx
            echo "Hello World From Host: $(hostname -I)" > /usr/share/nginx/html/
            EOF
}


module "nginx_ec22" {
  source = "./ec2_module"
  ami = "ami-05b10e08d247fb927"
  isPublic = true
  key_pair = aws_key_pair.ivolve_key_pair.key_name
  subnet_id = module.public_subnet2.id
  security_group_ids = [ aws_security_group.public_security.id ]
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