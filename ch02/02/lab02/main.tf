resource "aws_security_group" "name" {
    name = "${local.project}-sg-web"
    description = "${local.project} default_tags test"

    tags = {
      Name = "${local.project}-sg-web"
    }
  
}