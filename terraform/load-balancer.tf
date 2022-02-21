#---------------------- Load balancer -----------------------#

resource "aws_lb" "cloud_gateway_lb" {

  name               = "${var.global_vars["stack_name"]}-lb-${var.global_vars["env"]}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.cloud_gateway_lb.id]
  subnets            = var.aws_subnet_ids
}

#---------------------- Listener -----------------------#


resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.cloud_gateway_lb.arn
  port              = local.https_port
  protocol          = "HTTPS"

  ssl_policy      = "ELBSecurityPolicy-2016-08"
  certificate_arn = var.certificate_arn


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cloud_gateway_tg.arn
  }
}


#---------------------- Listener Rule   -----------------------#
resource "aws_lb_listener_rule" "https_rule" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cloud_gateway_tg.arn
  }
}


#---------------------- Target Group  -----------------------#

resource "aws_lb_target_group" "cloud_gateway_tg" {
  name     = "${var.global_vars["stack_name"]}-tg-${var.global_vars["env"]}"
  port     = local.traffic_port
  protocol = "HTTP"
  vpc_id   = var.aws_vpc_id


  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}


