output "instance" {
  value = {
    (local.instance.name) = {
      id         = aws_instance.this.id
      public_ip  = aws_instance.this.public_ip
      private_ip = aws_instance.this.private_ip
    }
  }
}