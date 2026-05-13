output "instance" {
    value = aws_instance.this.id
}
output "sg" {
    value = aws_security_group.this.id  
}

output "iamprofile" {
    value = aws_iam_instance_profile.this.name  
}

output "iamrole" {
    value = aws_iam_role.this
}
