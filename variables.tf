variable "ip_address" {
    type = string 
}

variable "ami_id" {
    type = string
    default = "ami-0d058fe428540cd89"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}