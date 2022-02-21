
#---------------------- Instance Profile  -----------------------#

module "cloud_gateway_profile" {
  source             = "../modules/iam"
  global_vars        = var.global_vars
  bucket_access_role = var.bucket_access_role
}


#--------------------------- SSH KEY [optional] -------------------------#

module "ssh_key" {

  source = "../modules/aws-key"

  count      = var.enable_ssh ? 1 : 0
  key_name   = var.key_name
  public_key = var.public_key

}

#-------------------------- Cloud Gateway -----------------------#

module "cloud_gateway" {
  source = "../modules/cloud-gateway"

  ami_id              = var.image_id
  vpc_id              = var.aws_vpc_id
  vpc_subnets         = var.aws_subnet_ids
  instance_type       = var.instance_type
  aws_certificate_arn = var.certificate_arn
  global_vars         = var.global_vars
  key_name            = var.enable_ssh ? var.key_name : ""
  ssh_cidr            = var.enable_ssh ? var.ssh_cidr : []    
  instance_profile    = module.cloud_gateway_profile.instance_profile_arn
  bucket_access_role  = var.bucket_access_role

}

#---------------------- DNS [optional]-----------------------#
module "cloud_gateway_dns" {

  source = "../modules/dns"

  count          = length(var.domain_name) != 0 ? 1 : 0
  zone_id        = var.zone_id
  domain_name    = var.domain_name
  lb_domain_name = module.cloud_gateway.alb_dns_name
  lb_zone_id     = module.cloud_gateway.alb_zone_id
}
