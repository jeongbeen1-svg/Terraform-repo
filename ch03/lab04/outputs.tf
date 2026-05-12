output "public_ip" {
  value       = aws_instance.web_server.public_ip
  description = "생성된 EC2의 공인 IP 주소"
}
