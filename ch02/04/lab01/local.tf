locals {
  project = "04-lab01"


  # IAM Role 관련 값을 객체로 묶어서 관리
  iamrole = {
    name = "instance"

    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })

  # 정의된 정책은 main.tf와 연결 (ssm 접근하기 위한 정책)
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }
  
  instance = {
    name = "ssm-test"
    
    # main.tf에서 정의한 local ec2 스펙
    ami = "ami-0c003e98ceffee43e"           # ← 관련값끼리 객체로 묶음
    instance_type = "t3.micro"
    associate_public_ip_address = true

    # 포트도 정의
    allow_access = {                        # ← 관련값끼리 객체로 묶음
      port = 80
      cidr_blocks = ["0.0.0.0/0"]
    }

  }
}
