# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

#########################################
# Lambda Functions
#########################################

resource "aws_cloudwatch_log_group" "sce_lambda_terraform_parameter_parser" {
  name              = "${local.cloudwatch.lambda_log_group_prefix}/${local.service_catalog.lambda_parameter_parser_name}"
  kms_key_id        = aws_kms_alias.sce.target_key_arn
  retention_in_days = var.cloudwatch_log_group_retention
}
