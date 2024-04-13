# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

output "kms_key_arn" {
  description = "KMS key for Service Catalog Engine Core"
  value = aws_kms_alias.sce.target_key_arn
}

output "sce_parameter_parser_role_arn" {
  description = "IAM role ARN used by Lambda parameter parser"
  value = aws_iam_role.sce_parameter_parser.arn
}

output "sqs_provision_queue_arn" {
  description = "SQS queue for product provisioning requests"
  value = aws_sqs_queue.sce_provision_queue.arn
}

output "sqs_termination_queue_arn" {
  description = "SQS queue for product termination requests"
  value = aws_sqs_queue.sce_termination_queue.arn
}

output "sqs_update_queue_arn" {
  description = "SQS queue for product update requests"
  value = aws_sqs_queue.sce_update_queue.arn
}

output "sqs_dlq_arn" {
  description = "SQS queue for death letter queue"
  value = aws_sqs_queue.sce_dlq.arn
}