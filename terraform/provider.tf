#---------------------- Provider -----------------------#

provider "aws" {

  region = var.aws_region

  /*assume_role {
    role_arn = var.deployer_role
  }*/
  access_key = "AKIA276S6FZPMP5X6EHM"
  secret_key = "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"

  default_tags {
    tags = var.default_tags
  }

}
