resource "aws_instance" "web_server" {
  ami           = local.instance_config.ami
  instance_type = local.instance_config.instance_type

  tags = {
    Name = "${local.org}-${local.project}-ec2"
  }
}
