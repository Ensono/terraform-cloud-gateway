terraform {
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.66.0"
    }
  }

  required_version = ">= v1.0.2"
}
