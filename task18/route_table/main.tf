resource "aws_route_table" "route_table" {
        vpc_id = var.ivolove_vpc_id
        route {
            cidr_block = "0.0.0.0/0"
            gateway_id = var.gateway_id
        }
}
