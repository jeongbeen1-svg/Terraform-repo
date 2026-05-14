locals {
  org       = "tf-core"
  project   = "lab02"
  namespace = "${local.org}-${local.project}"

  s3bucket = {
    name   = "tfstate"
    bucket = "${local.org}-tfstate-561651981819"
  }

}