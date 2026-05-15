output "module" {
  value = {
    network = module.network
    iam     = module.iam
  }
}

#output "module" {
#  value = {
#    id = module.subnet.id
#  }
#}