# main.tf
resource "aws_s3_bucket" "this" {
  bucket = local.s3bucket.name 
}

resource "aws_security_group" "this" {
  name = "${local.namespace}-sg"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.namespace}-sg"
  }
}