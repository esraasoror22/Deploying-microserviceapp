
variable "pub_ec2_names" {
    type = list(string)
    
}
variable "public_ec2_subnets" {
    type = list(string)
}

variable "sgg" {
    type = list(string)
}

variable "private_ec2_names" {
    type = list(string)

}

variable "private_ec2_subnets"{
    type = list(string)
}

variable "private_ec2_SG" {
    type = list(string)
}