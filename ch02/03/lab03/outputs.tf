output "instance" {
    value = aws_instance.instance.id
}
output "sg" {
    value = aws_security_group.instance.id  
}

output "iamprofile" {
    value = aws_iam_instance_profile.instance.name  
}

output "iamrole" {
    value = aws_iam_role.instance.id
}
