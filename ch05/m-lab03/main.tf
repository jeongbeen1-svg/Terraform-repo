module "workload" {
  source    = "./modules/workload"
  namespace = local.namespace

  vpc_id               = module.network.vpc_id
  subnet_id            = module.network.subnet_id
  iam_instance_profile = module.iam.iamprofile.name
}

module "iam" {
  source    = "./modules/iam"
  namespace = local.namespace
}

module "network" {
  source    = "./modules/network"
  namespace = local.namespace

}

