# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

############################################################################################################
# sce_parameter_parser
############################################################################################################

data "aws_s3_object" "sce_parameter_parser" {
  bucket = var.lambda_sce_parameter_parser_s3_bucket
  key    = var.lambda_sce_parameter_parser_s3_key
}

resource "aws_lambda_function" "sce_parameter_parser" {
  #checkov:skip=CKV_AWS_115:Concurrent execution limit not required
  #checkov:skip=CKV_AWS_272:Code signing not required

  architectures = var.lambda_sce_parameter_parser_architectures
  dead_letter_config {
    target_arn = aws_sqs_queue.sce_dlq.arn
  }

  description      = var.lambda_sce_parameter_parser_description
  function_name    = local.service_catalog.lambda_parameter_parser_name
  handler          = var.lambda_sce_parameter_parser_handler
  memory_size      = var.lambda_sce_parameter_parser_memory_size
  role             = aws_iam_role.sce_parameter_parser.arn
  runtime          = var.lambda_sce_parameter_parser_runtime
  s3_bucket        = data.aws_s3_object.sce_parameter_parser.bucket
  s3_key           = data.aws_s3_object.sce_parameter_parser.key
  source_code_hash = data.aws_s3_object.sce_parameter_parser.checksum_sha256
  tags             = var.tags
  timeout          = var.lambda_sce_parameter_parser_timeout

  dynamic "vpc_config" {
    for_each = local.vpc_deployment ? [1] : [0]
    content {
      subnet_ids         = local.vpc_deployment ? var.vpc_private_subnet_ids : []
      security_group_ids = local.vpc_deployment ? var.vpc_security_group_ids : []
    }
  }
  tracing_config {
    mode = "Active"
  }
  depends_on = [aws_cloudwatch_log_group.sce_lambda_terraform_parameter_parser]
}

resource "aws_lambda_permission" "sce_parameter_parser" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.sce_parameter_parser.arn
  principal     = local.service_catalog.principal
  statement_id  = "AllowInvokeByServiceCatalog"
}