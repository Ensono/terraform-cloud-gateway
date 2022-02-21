variable "zone_id" {

  type        = string
  description = "AWS Zone ID of the domain-name"
}

variable "domain_name" {

  type        = string
  description = "DNS Name"
}

variable "lb_domain_name" {

  type        = string
  description = "DNS Name of the load-balancer"
}


variable "lb_zone_id" {


  type        = string
  description = "AWS Zone ID of the load-balancer"
}
