<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sce_core"></a> [sce\_core](#module\_sce\_core) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_lambda_sce_parameter_parser_s3_bucket"></a> [lambda\_sce\_parameter\_parser\_s3\_bucket](#input\_lambda\_sce\_parameter\_parser\_s3\_bucket) | S3 bucket name containting the Lambda source code .zip file | `string` | n/a | yes |
| <a name="input_lambda_sce_parameter_parser_s3_key"></a> [lambda\_sce\_parameter\_parser\_s3\_key](#input\_lambda\_sce\_parameter\_parser\_s3\_key) | S3 bucket key of the Lambda source code .zip file | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->