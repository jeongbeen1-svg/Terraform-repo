output "iamprofile" {
  value = {
    name = aws_iam_instance_profile.this.name
    arn  = aws_iam_instance_profile.this.arn
  }
}