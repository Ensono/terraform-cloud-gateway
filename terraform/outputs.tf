output "gateway_dns_name" {
  value = aws_lb.cloud_gateway_lb.dns_name
}

output "gateway_public_dns" {
  value = length(module.cloud_gateway_dns) > 0 ? module.cloud_gateway_dns[0].public_dns : ""
}

output "instance_profile_arn" {
  value = module.cloud_gateway_profile.instance_profile_arn
}

output "role_arn" {
  value = module.cloud_gateway_profile.role_arn

}
