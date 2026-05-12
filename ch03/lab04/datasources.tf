# 최신 Amazon Linux 2 AMI ID를 자동으로 찾아옴
data "aws_ami" "latest_amzn2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
