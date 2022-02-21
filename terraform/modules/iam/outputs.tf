output "instance_profile_arn" {

  value = aws_iam_instance_profile.cloud_gateway_profile.arn
}

output "rendered_bucket_access" {

  value = data.aws_iam_policy_document.bucket_access.json
}

output "role_arn" {

  value = aws_iam_role.cloud_gateway_role.arn
}
