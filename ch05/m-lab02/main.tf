module "iam" {
  source    = "./modules/iam"
  namespace = local.namespace
}

module "network" {
  source    = "./modules/network"
  namespace = local.namespace
}