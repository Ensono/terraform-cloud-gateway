#---------------------- Provider -----------------------#

provider "aws" {

  region = var.aws_region

  assume_role {
    role_arn = var.deployer_role
  }

  default_tags {
    tags = var.default_tags
  }

}
