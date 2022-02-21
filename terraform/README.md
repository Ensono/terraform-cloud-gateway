# Cloud-Gateway AWS Bundle

[Cloud-Gateway Documentation](https://iagtech.atlassian.net/wiki/spaces/IAGIDAM/pages/642974005/IIQ+CloudGateway)

## Deployment bundle includes:

- terraform module 
    - Create an ASG(1:1) and LB for CloudGateway instances
    - Security Group to control network traffic
    - Optionally Create Route53 record set to attach a public dns name to the load balancers
    - Optionally injects a ssh public key if there is an requirement to shell in to the instances 

## Deployment process : 


1. Select required environment folder eg: staging or for reference example folder or even you can run terraform from the  root module by placing the correct .tfvar file.

2. For deploying into another environment make a copy of the contents in the example folder to the target folder with correct source module path.

3. Populate the terraform.tfvars file or configure terraform env parameters with the required inputs, depending on the cloud environment setup.

4. [_Optional_] Pass the required CIDR range for SSH **Deafult is set to false** and public-key details if you require to shell into the vm's.

5. [_Optional_] Pass a valid domain name and zone-id to create a custom alias record against the default load-balancer dns name. 

5. Invoke ``` terraform plan ``` 

6. Invoke ``` terraform apply / terraform plan && terraform apply --auto-aprrove ``` 

7. You can find the dns endpoint and public key information from the output of the module 
   or run ``` terraform output ```


*N.B: Deploy the stack in public subnets* 

---

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= v1.0.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.66.0 |

## Providers

AWS provider

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_gateway"></a> [cloud\_gateway](#module\_cloud\_gateway) | ./modules/cloud-gateway | n/a |
| <a name="module_cloud_gateway_dns"></a> [cloud\_gateway\_dns](#module\_cloud\_gateway\_dns) | ./modules/dns | n/a |
| <a name="module_cloud_gateway_profile"></a> [cloud\_gateway\_profile](#module\_cloud\_gateway\_profile) | ./modules/iam | n/a |
| <a name="module_ssh_key"></a> [ssh\_key](#module\_ssh\_key) | ./modules/aws-key | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | n/a | yes |
| <a name="input_aws_subnet_ids"></a> [aws\_subnet\_ids](#input\_aws\_subnet\_ids) | List of subnet ids within a vpc | `list(any)` | n/a | yes |
| <a name="input_aws_vpc_id"></a> [aws\_vpc\_id](#input\_aws\_vpc\_id) | Id of the VPC where cloud-gateway will be deployed | `string` | n/a | yes |
| <a name="input_bucket_access_role"></a> [bucket\_access\_role](#input\_bucket\_access\_role) | ARN of the cross-account role | `string` | n/a | yes |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | ARN of the SSL/TLS Certificate | `string` | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default tags | `map(string)` | `{}` | no |
| <a name="input_deployer_role"></a> [deployer\_role](#input\_deployer\_role) | AWS IAM Role used to deploy the infrastructure | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Rote53 FQDN for cloud-gateway | `string` | n/a | no |
| <a name="input_enable_ssh"></a> [enable\_ssh](#input\_enable\_ssh) | n/a | `bool` | `false` | no |
| <a name="input_global_vars"></a> [global\_vars](#input\_global\_vars) | Common vars like stack and env names | `map(string)` | `{}` | yes |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | AWS AMI used to launch the instance | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Type of hardware, combination of cpu and memory | `string` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Name of the public key | `string` | n/a | yes |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | Public Key | `string` | n/a | yes |
| <a name="input_ssh_cidr"></a> [ssh\_cidr](#input\_ssh\_cidr) | CIDR Range to establish SSH connection | `list(string)` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Rote53 ZONE ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gateway_dns_name"></a> [gateway\_dns\_name](#output\_gateway\_dns\_name) | n/a |
| <a name="output_gateway_public_dns"></a> [gateway\_public\_dns](#output\_gateway\_public\_dns) | n/a |
| <a name="output_instance_profile_arn"></a> [instance\_profile\_arn](#output\_instance\_profile\_arn) | n/a |
| <a name="output_public_key_name"></a> [public\_key\_name](#output\_public\_key\_name) | n/a |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | n/a |
