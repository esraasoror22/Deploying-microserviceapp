
variable "vpc_cidr" {

    type = string
}

variable "public_subnet_cidr" {

    type = list(string)
}

variable "public_subnet_names" {

    type = list(string)
}

variable "availability_zone" {

    type = list(string)
}

variable "private_subnet_cidr" {
    type = list(string)
}

variable "private_subnet_names" {
    type = list(string)
}

#private_subnet_cidr private_subnet_names