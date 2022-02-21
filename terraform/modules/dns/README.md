## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.lb_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | DNS Name | `string` | n/a | yes |
| <a name="input_lb_domain_name"></a> [lb\_domain\_name](#input\_lb\_domain\_name) | DNS Name of the load-balancer | `string` | n/a | yes |
| <a name="input_lb_zone_id"></a> [lb\_zone\_id](#input\_lb\_zone\_id) | AWS Zone ID of the load-balancer | `string` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | AWS Zone ID of the domain-name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_public_dns"></a> [public\_dns](#output\_public\_dns) | n/a |
