output "instance" {
  value = aws_instance.this.id
}
output "web_endpoint" {
  value = "http://${aws_instance.this.public_ip}"
}