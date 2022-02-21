#-------------------- Data Sources ------------------#
data "aws_iam_policy_document" "bucket_access" {
  statement {
    sid       = "allowAccessToAssumeRoleInSharedAccount"
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::462418267981:${var.bucket_access_role}"]
  }
}

data "aws_iam_policy_document" "default_instance" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy_document" "ssm_access" {
  statement {
    sid       = "allowSSMAccessToListDocuments"
    effect    = "Allow"
    actions   = ["ssm:ListDocuments"]
    resources = ["arn:aws:iam::462418267981:${var.bucket_access_role}"]
  }
}

#---------------------- Resources -------------------#

# Create Instance Profile
resource "aws_iam_instance_profile" "cloud_gateway_profile" {
  name = "${var.global_vars["stack_name"]}-profile-${var.global_vars["env"]}"
  role = aws_iam_role.cloud_gateway_role.name
}

# Create IAM Role
resource "aws_iam_role" "cloud_gateway_role" {
  name               = "${var.global_vars["stack_name"]}-role-${var.global_vars["env"]}"
  description        = "Allow cloud-gateway instance to do cross account switch role and access software packages from S3 bucket"
  path               = "/cloud-gateway/"
  assume_role_policy = data.aws_iam_policy_document.default_instance.json
}


# Create IAM policy to give role permission to assume IAM Role in 462418267981 account
resource "aws_iam_role_policy" "assume_role_policy" {
  name   = "${var.global_vars["stack_name"]}-access_bucket-${var.global_vars["env"]}"
  role   = aws_iam_role.cloud_gateway_role.id
  policy = data.aws_iam_policy_document.bucket_access.json
}

resource "aws_iam_role_policy" "ssm_policy" {
  name   = "${var.global_vars["stack_name"]}-access_ssm-${var.global_vars["env"]}"
  role   = aws_iam_role.cloud_gateway_role.id
  policy = data.aws_iam_policy_document.ssm_access.json
}