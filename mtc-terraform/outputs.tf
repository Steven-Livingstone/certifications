output "load_balancer_endpoint" {
  value = module.loadbalancing.lb_endpoint
}

output "instances" {
  value = {for i in module.compute.instance : i.tags.Name =>  "${i.public_ip}:${module.compute.instance.*.public_ip[0]}"}
  sensitive = true
}


output "kubeconfig" {
  value     = [for i in module.compute.instance : "export KUBECONFIG=k3s-${i.tags.Name}.yaml"]
  sensitive = true
}

output "k3s" {
  value     = [for i in module.compute.instance : "k3s-${i.tags.Name}.yaml"][0]
  sensitive = true
}