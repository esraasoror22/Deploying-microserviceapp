
output "public_ecs_security" {
   value = aws_security_group.SG.id
}


output "private_ec2_Security" {
    value = aws_security_group.privatee_ec2_SG.id
}