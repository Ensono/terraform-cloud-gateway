# This is a sample Input variable looks like

```
# Module Inputs
aws_region     = "eu-west-1"
image_id       = "ami-09d4a659cdd8677be"
instance_type  = "t2.micro"
key_name       = ""
aws_vpc_id     = "vpc-0a9aa10e33ba82630"
aws_subnet_ids = ["subnet-0da40caa2b92fae9b", "subnet-01450cb73e85506f8"]
ssh_cidr       = ["0.0.0.0/0"] # Pass the Trusted CIDR Range 
public_key     = ""
deployer_role  = "arn:aws:iam::678378937564:role/iag-idam-dev-orchestration"
enable_ssh     = false

# Certificate and Target IAM Role to be assumed by Instance-profile
certificate_arn    = "arn:aws:acm:eu-west-1:678378937564:certificate/be3878ad-06b8-4842-ac41-299daf1b85aa"
bucket_access_role = "role/iag-idam-sharedservices-ssvc-root-satellite-components"

# DNS
zone_id     = "Z07493473E7XSD04X9AFX"
domain_name = "cloud-gateway.nonprod.idam.iag.cloud"


# Global Tags should only be used to set stack-name and logical environments like stage, dev, pre-prod, prod etc
global_vars = {
  stack_name = "cloud-gateway"
  env        = "test" # This environment value is used to form resource name, so for consistency its better to keep same value as the below environemnt in default tag dictionary. 
}

# The Default Tags can be extended like adding cost-code or organization name
default_tags = {
  Environment = "Test"
  Owner       = "Terraform"
  Project     = "IDAM"
}
```



