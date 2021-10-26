locals {
    public_ip_in_cidr_form = ["${var.ip_address}/32"]
}

data "aws_vpc" "default_vpc" {
    default = true
}

# create custom security group 
# default rules for a newly created security group => allows no inbound traffic, allows all outbound traffic
resource "aws_security_group" "app_firewall" {
    name = "app-firewall"
    description =  "Rules for app server"
    vpc_id = data.aws_vpc.default_vpc.id
}

# inbound rules that allow SSH access from my public ip address
resource "aws_security_group_rule" "allow_ssh_access" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = local.public_ip_in_cidr_form
    security_group_id = aws_security_group.app_firewall.id
}


resource "aws_instance" "instance" {
    ami = var.ami_id   
    instance_type = var.instance_type
    key_name = "hw4-key-pair"
    vpc_security_group_ids = [aws_security_group.app_firewall.id]
    tags = {
        Name = "px-devtools-hw4"
    } 
}

