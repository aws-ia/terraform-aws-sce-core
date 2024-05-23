<!-- BEGIN_TF_DOCS -->
# Terraform Service Catalog Engine - Core

This modules deploys the core engine components needed to support `EXTERNAL` AWS Service Catalog products.

## Architecture Diagram

![SCE Core Architecture](/assets/Architecture.png)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.41.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_label"></a> [label](#module\_label) | git::https://github.com/aws-ia/terraform-aws-label.git | 9595b11aadf520f5ee3c210848802c414441236f |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.sce_lambda_terraform_parameter_parser](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.aws_lambda_basic_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.aws_lambda_vpc_access_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.aws_lambda_xray_write_only_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.sce_parameter_parser](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.sce_parameter_parser](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.sce_parameter_parser](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_alias.sce](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.sce](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_lambda_function.sce_parameter_parser](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.sce_parameter_parser](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_sqs_queue.sce_dlq](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.sce_provision_queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.sce_termination_queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.sce_update_queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue_policy.sce_provision_queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |
| [aws_sqs_queue_policy.sce_termination_queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |
| [aws_sqs_queue_policy.sce_update_queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy.AWSLambdaBasicExecutionRole](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.AWSLambdaVPCAccessExecutionRole](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.AWSXrayWriteOnlyAccess](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_s3_object.sce_parameter_parser](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_object) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_lambda_sce_parameter_parser_architectures"></a> [lambda\_sce\_parameter\_parser\_architectures](#input\_lambda\_sce\_parameter\_parser\_architectures) | Instruction set architecture for your Lambda function. | `list(string)` | n/a | yes |
| <a name="input_lambda_sce_parameter_parser_handler"></a> [lambda\_sce\_parameter\_parser\_handler](#input\_lambda\_sce\_parameter\_parser\_handler) | Function entrypoint in your code. | `string` | n/a | yes |
| <a name="input_lambda_sce_parameter_parser_runtime"></a> [lambda\_sce\_parameter\_parser\_runtime](#input\_lambda\_sce\_parameter\_parser\_runtime) | Identifier of the function's runtime. | `string` | n/a | yes |
| <a name="input_lambda_sce_parameter_parser_s3_bucket"></a> [lambda\_sce\_parameter\_parser\_s3\_bucket](#input\_lambda\_sce\_parameter\_parser\_s3\_bucket) | S3 bucket name containting the Lambda source code .zip file | `string` | n/a | yes |
| <a name="input_lambda_sce_parameter_parser_s3_key"></a> [lambda\_sce\_parameter\_parser\_s3\_key](#input\_lambda\_sce\_parameter\_parser\_s3\_key) | S3 bucket key of the Lambda source code .zip file | `string` | n/a | yes |
| <a name="input_cloudwatch_log_group_retention"></a> [cloudwatch\_log\_group\_retention](#input\_cloudwatch\_log\_group\_retention) | Amount of days to keep CloudWatch Log Groups for Lambda functions. 0 = Never Expire | `string` | `"0"` | no |
| <a name="input_label_id_order"></a> [label\_id\_order](#input\_label\_id\_order) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `list(string)` | <pre>[<br>  "name",<br>  "namespace",<br>  "stage"<br>]</pre> | no |
| <a name="input_lambda_sce_parameter_parser_description"></a> [lambda\_sce\_parameter\_parser\_description](#input\_lambda\_sce\_parameter\_parser\_description) | Description of what your Lambda Function does | `string` | `"Parses parameters - Invoked by Service Catalog"` | no |
| <a name="input_lambda_sce_parameter_parser_memory_size"></a> [lambda\_sce\_parameter\_parser\_memory\_size](#input\_lambda\_sce\_parameter\_parser\_memory\_size) | Amount of memory in MB your Lambda Function can use at runtime | `number` | `1024` | no |
| <a name="input_lambda_sce_parameter_parser_timeout"></a> [lambda\_sce\_parameter\_parser\_timeout](#input\_lambda\_sce\_parameter\_parser\_timeout) | Amount of time your Lambda Function has to run in seconds. | `number` | `100` | no |
| <a name="input_lambda_sce_parameter_tracing_config_mode"></a> [lambda\_sce\_parameter\_tracing\_config\_mode](#input\_lambda\_sce\_parameter\_tracing\_config\_mode) | Whether to sample and trace a subset of incoming requests with AWS X-Ray. Valid values are PassThrough and Active. | `string` | `"Active"` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to apply to resources deployed by this solution. | `map(any)` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID to use if leveraging an existing VPC for the solution. | `string` | `null` | no |
| <a name="input_vpc_private_subnet_ids"></a> [vpc\_private\_subnet\_ids](#input\_vpc\_private\_subnet\_ids) | Required if `vpc_id` is specified. List of private subnets to use in the provided vpc\_id | `list(string)` | `null` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | Required if `vpc_id` is specified. List of security groups to use in the provided vpc\_id | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | KMS key for Service Catalog Engine Core |
| <a name="output_sce_parameter_parser_role_arn"></a> [sce\_parameter\_parser\_role\_arn](#output\_sce\_parameter\_parser\_role\_arn) | IAM role ARN used by Lambda parameter parser |
| <a name="output_sqs_dlq_arn"></a> [sqs\_dlq\_arn](#output\_sqs\_dlq\_arn) | SQS queue for death letter queue |
| <a name="output_sqs_provision_queue_arn"></a> [sqs\_provision\_queue\_arn](#output\_sqs\_provision\_queue\_arn) | SQS queue for product provisioning requests |
| <a name="output_sqs_termination_queue_arn"></a> [sqs\_termination\_queue\_arn](#output\_sqs\_termination\_queue\_arn) | SQS queue for product termination requests |
| <a name="output_sqs_update_queue_arn"></a> [sqs\_update\_queue\_arn](#output\_sqs\_update\_queue\_arn) | SQS queue for product update requests |
<!-- END_TF_DOCS -->