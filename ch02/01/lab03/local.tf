locals {
  org     = "tf-core"
  project = "lab03"

  namespace = "${local.org}-${local.project}"

  sg = {
    name = format("%s-%s-sg-web", local.org, local.project)

    tags = {
      Name = join("-", [local.org, local.project, "sg", "web"])
    }
  }

  instance = {
    ami           = "ami-1234567890"
    instance_type = var.env == "prod" ? "t3.small" : "t3.micro"
  }
}


