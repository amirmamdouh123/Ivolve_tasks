resource "aws_instance" "ec2" {
    instance_type = "t2.micro"
    ami = var.ami
    associate_public_ip_address = var.isPublic
    key_name = var.key_pair
    user_data = var.user_data
    subnet_id = var.subnet_id
    vpc_security_group_ids= var.security_group_ids
}
