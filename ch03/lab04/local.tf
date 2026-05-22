locals {
  org     = "tf-core"
  project = "lab03"

  # 변수와 데이터를 조합해 인스턴스 설정 가공
  instance_config = {
    ami           = data.aws_ami.latest_amzn2.id                # 데이터 소스 참조
    instance_type = var.env == "prod" ? "t3.small" : "t3.micro" # 변수 참조
  }
}
