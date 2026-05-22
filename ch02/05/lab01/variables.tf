# variables.tf
# 외부에서 주입받을 최소한의 값만 선언
# → 나머지는 locals에서 파생 (variables 최소화 원칙)

# 변수 인스턴스 타입
variable "instance_type" {
  type = string
  # 인스턴스 타입 스펙
  default     = "t3.micro"
  description = "EC2 Instance Type (t3.micro, t3.small, t3.medium)"

  # condition, contains 값을 넣어 값 이외의 인스턴스 타입을 방지
  # validation → 허용된 값 이외 입력 시 apply 전에 차단
  # contains() → 리스트에 값이 포함되는지 확인하는 내장함수
  validation {
    condition = contains(["t3.micro", "t3.small", "t3.medium"], var.instance_type)
    # 그외의 인스턴스 타입이 들어가게 되면 에러메시지 출력
    error_message = "instance_type은 t3.micro, t3.small, t3.medium 중 하나여야 한다."
  }
}

# 서비스 포트 변수
variable "service_port" {
  type = number
  # 기본값은 8080
  default     = 8080
  description = "Service Port (1~65535)"

  # 포트 유효 범위 검증 → 범위 밖 값 입력 시 에러
  # && → AND 조건 (둘 다 만족해야 통과)
  validation {
    condition     = 1 <= var.service_port && var.service_port <= 65535
    error_message = "service_port는 1~65535 범위여야 한다."
  }
}

# cidr blocks 변수
variable "cidr_blocks" {
  type = list(string)
  # 기본값은 모든 IP
  default     = ["0.0.0.0/0"]
  description = "Security Group Allowed CIDR Blocks"


  # 빈 리스트 방지 → 최소 1개 이상의 CIDR 필수
  # length() → 리스트 길이 반환하는 내장함수
  validation {
    condition     = length(var.cidr_blocks) > 0
    error_message = "cidr_blocks는 최소 1개 이상의 CIDR을 포함해야 한다."
  }
}