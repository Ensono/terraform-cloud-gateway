variable "bucket_access_role" {

  type        = string
  description = "ARN of the cross-account role"

}

variable "global_vars" {


  type        = map(string)
  default     = {}
  description = "Common vars like stack and env names"
}


