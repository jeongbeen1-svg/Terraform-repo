locals {
  org         = "tf-core"
  project     = "lab02"
  environment = terraform.workspace

  namespace = "${local.org}-${local.project}-${local.environment}"
}