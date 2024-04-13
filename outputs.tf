# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

output "kms_key_arn" {
  value = aws_kms_alias.sce.target_key_arn
}

output "sce_parameter_parser_role_arn" {
  value = aws_iam_role.sce_parameter_parser.arn
}

output "sqs_provision_queue_arn" {
  value = aws_sqs_queue.sce_provision_queue.arn
}

output "sqs_termination_queue_arn" {
  value = aws_sqs_queue.sce_termination_queue.arn
}

output "sqs_update_queue_arn" {
  value = aws_sqs_queue.sce_update_queue.arn
}

output "sqs_dlq_arn" {
  value = aws_sqs_queue.sce_dlq.arn
}