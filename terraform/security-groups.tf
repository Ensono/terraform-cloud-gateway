#---------------------- ASG Security group -----------------------#

resource "aws_security_group" "cloud_gateway_asg" {

  name        = "${var.global_vars["stack_name"]}-asg-${var.global_vars["env"]}"
  description = "Controls Traffic for Cloud Gateway ASG"
  vpc_id      = var.aws_vpc_id

  tags = {
    "Name" = "${var.global_vars["stack_name"]}-asg-${var.global_vars["env"]}"
  }

}

resource "aws_security_group_rule" "ingress_asg_8080" {

  type                     = "ingress"
  from_port                = local.traffic_port
  to_port                  = local.traffic_port
  protocol                 = local.tcp_protocol
  source_security_group_id = aws_security_group.cloud_gateway_lb.id
  security_group_id        = aws_security_group.cloud_gateway_asg.id

  description = "Allow Traffic on 8080 From Load-balancer"
}

resource "aws_security_group_rule" "egress_asg_all" {

  type              = "egress"
  from_port         = local.any_port
  to_port           = local.any_port
  protocol          = local.any_protocol
  cidr_blocks       = local.all_ips
  security_group_id = aws_security_group.cloud_gateway_asg.id

  description = "Allow All Traffic"


}

#---------------------- LB Security group -----------------------#

resource "aws_security_group" "cloud_gateway_lb" {
  name        = "${var.global_vars["stack_name"]}-lb-${var.global_vars["env"]}"
  description = "Controls Traffic for Cloud Gateway Load-balancer"
  vpc_id      = var.aws_vpc_id

  tags = {
    "Name" = "${var.global_vars["stack_name"]}-lb-${var.global_vars["env"]}"
  }
}

resource "aws_security_group_rule" "ingress_lb_https" {

  type              = "ingress"
  from_port         = local.https_port
  to_port           = local.https_port
  protocol          = local.tcp_protocol
  cidr_blocks       = local.all_ips
  security_group_id = aws_security_group.cloud_gateway_lb.id

  description = "Allow HTTPS From World"
}

resource "aws_security_group_rule" "egress_lb_all" {

  type              = "egress"
  from_port         = local.any_port
  to_port           = local.any_port
  protocol          = local.any_protocol
  cidr_blocks       = local.all_ips
  security_group_id = aws_security_group.cloud_gateway_lb.id

  description = "Allow All Traffic"

}

# Uncomment if require a listener in an unsecure port while testing

# resource "aws_security_group_rule" "ingress_lb_http" {

#   type        = "ingress"
#   from_port   = 80
#   to_port     = 80
#   protocol    = "tcp"
#   description = "Allow HTTP From World"

#   cidr_blocks = ["0.0.0.0/0"]

#   security_group_id = aws_security_group.cloud_gateway_lb.id
# }



