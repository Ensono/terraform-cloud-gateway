# Create an aws route53 record which supports the SSL/TLS Certificate

resource "aws_route53_record" "lb_dns" {
  zone_id = var.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.lb_domain_name
    zone_id                = var.lb_zone_id
    evaluate_target_health = true
  }
}