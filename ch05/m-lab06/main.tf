module "network" {
  source    = "./modules/network"
  namespace = local.namespace
}

module "platform" {
  source    = "./modules/platform"
  namespace = local.namespace

  vpc_id     = module.network.vpc["main"].id
  lb_subnets = [module.network.subnet["public-a"].id, module.network.subnet["public-b"].id]
}