# 생서된 리소스 정보를 외부로 출력
# → 루트모듈에서는 콘솔 출력, 상위모듈에서는 module.xxx.yyy 로 참조 가능

# 인스턴스 ID 출력
output "instance" {
  value = aws_instance.instance.id
}
# 시큐리티그룹 ID 출력
output "sg" {
  value = aws_security_group.instance.id
}
# iam 프로필 이름 출력
# .id가 아닌 .name 인 이유: 프로필은 이름으로 EC2에 연결하기 때문
output "iamprofile" {
  value = aws_iam_instance_profile.instance.name
}
# iam 역할 ID 출력
output "iamrole" {
  value = aws_iam_role.instance.id
}
