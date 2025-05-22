output "alb_dns_name" {
  value       = module.hello_world_app.alb_dns_name
  description = "The domain name of the load balancer"
}

output "alb_security_group_id" {
  value       = module.hello_world_app.alb_security_group_id
  description = "The ID of the Security Group attached to the load balancer"
}

output "asg_name" {
  value       = module.hello_world_app.asg_name
  description = "The name of the Auto Scaling Group"
}

output "instance_security_group_id" {
  value       = module.hello_world_app.instance_security_group_id
  description = "The ID of the EC2 Instance Security Group"
}
