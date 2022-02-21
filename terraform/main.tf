
#---------------------- Instance Profile  -----------------------#

module "cloud_gateway_profile" {
  source             = "./modules/iam"
  global_vars        = var.global_vars
  bucket_access_role = var.bucket_access_role
}

#---------------------- DNS [optional]-----------------------#
module "cloud_gateway_dns" {

  source = "./modules/dns"

  count          = length(var.domain_name) != 0 ? 1 : 0
  zone_id        = var.zone_id
  domain_name    = var.domain_name
  lb_domain_name = aws_lb.cloud_gateway_lb.dns_name
  lb_zone_id     = aws_lb.cloud_gateway_lb.zone_id
}
