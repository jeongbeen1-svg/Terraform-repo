#AWS SG 리소스 생성 선언
resource "aws_security_group" "name" {

  # 실제 AWS생성되는 SG 이름 "lab02-sg-web"
  name = "${local.project}-sg-web"

  description = "${local.project} default_tags test"

  tags = {
    Name = "${local.project}-sg-web"
  }

}