#----------------------- Data Section -------------------------#

data "aws_default_tags" "current" {}

#----------------------- User Data -----------------------#

# data "template_file" "user_data" {
#   template = file("${path.module}/user-data.tpl")
# }

#---------------------- Launch Configuration -----------------------#

resource "aws_launch_configuration" "cloud_gateway_template" {

  name_prefix                 = "${var.global_vars["stack_name"]}-tmpl-${var.global_vars["env"]}"
  image_id                    = var.image_id
  instance_type               = var.instance_type
  security_groups             = [aws_security_group.cloud_gateway_asg.id]
  associate_public_ip_address = true
  user_data = templatefile("${path.module}/../utils/userData.tpl", {

    BucketAccessRole = var.bucket_access_role
    RoleSessionName  = "gateway-bootstrap"
  })
  iam_instance_profile = module.cloud_gateway_profile.instance_profile_arn
  lifecycle {
    create_before_destroy = true
  }

}

#---------------------- Auto-Scaling Configuration -----------------------#

resource "aws_autoscaling_group" "cloud_gateway_asg" {
  name             = "${var.global_vars["stack_name"]}-${var.global_vars["env"]}"
  max_size         = 1
  min_size         = 1
  desired_capacity = 1


  launch_configuration = aws_launch_configuration.cloud_gateway_template.name
  vpc_zone_identifier  = var.aws_subnet_ids
  target_group_arns    = [aws_lb_target_group.cloud_gateway_tg.arn]
  health_check_type    = "ELB"

  tag {
    key                 = "Name"
    value               = "${var.global_vars["stack_name"]}-${var.global_vars["env"]}"
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = data.aws_default_tags.current.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}



