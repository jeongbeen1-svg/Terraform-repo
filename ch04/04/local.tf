# local.tf
locals {
  org       = "tf-core"
  project   = "lab02"
  namespace = "${local.org}-${local.project}"

  s3bucket = {
    name = "tf-core-tfstate5933"
  }
}