# 생성된 리소스 정보 출력
# → 루트 모듈: 터미널에 출력
# → 상위 모듈: module.xxx.yyy 로 참조 가능 (나중에 모듈화 시 핵심!)

output "instance" {
  value = aws_instance.this.id # EC2 인스턴스 ID (i-xxx)
}
output "sg" {
  value = aws_security_group.this.id # 보안그룹 ID (sg-xxx)
}
output "iamprofile" {
  value = aws_iam_instance_profile.this.name # 프로필 이름
}
output "iamrole" {
  # id만 출력하던 다른 output과 달리 role 객체 전체 출력
  # → arn, name, id 등 모든 속성 확인 가능
  value = aws_iam_role.this
}