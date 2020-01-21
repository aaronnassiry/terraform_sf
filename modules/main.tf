module "frontend"{
  source = "./aws_instances"
  cmds=["touch frontend.dat"]
}

module "backend"{
  source = "./aws_instances"
  total_instances = 2
  cmds=["touch backend.dat"]
}

output "front_end_ips"{
  value = module.frontend.ips
}

output "back_end_ips"{
  value = module.backend.ips
}

