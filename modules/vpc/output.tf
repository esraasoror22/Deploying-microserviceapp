
output "vpc_id" {

    value = aws_vpc.mainvpc.id
}

output "pub_subnets_id" {

    value = aws_subnet.public-subnet.*.id
}