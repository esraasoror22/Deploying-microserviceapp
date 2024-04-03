
output "vpc_id" {

    value = aws_vpc.mainvpc.id
}

output "vpc_cidr" {
    value = aws_vpc.mainvpc.cidr_block

}

output "pub_subnets_id" {

    value = aws_subnet.public-subnet.*.id
}


output "private_subnets_ids" {
    value = aws_subnet.private-subnet.*.id
}