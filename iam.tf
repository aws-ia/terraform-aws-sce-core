# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

############################################################################################################
# Generate customer-managed versions of AWSLambdaBasicExecutionRole, AWSLambdaVPCAccessExecutionRole
############################################################################################################
resource "aws_iam_policy" "aws_lambda_basic_execution" {
  name        = substr("${module.label.id}-aws-lambda-basic-execution", 0, 127)
  path        = "/"
  description = "Customer managed version of AWSLambdaBasicExecutionRole"

  policy = data.aws_iam_policy.AWSLambdaBasicExecutionRole.policy
  tags   = var.tags
}

resource "aws_iam_policy" "aws_lambda_vpc_access_execution" {
  name        = substr("${module.label.id}-aws-lambda-vpc-access-execution", 0, 127)
  path        = "/"
  description = "Customer managed version of AWSLambdaVPCAccessExecutionRole"

  policy = data.aws_iam_policy.AWSLambdaVPCAccessExecutionRole.policy
  tags   = var.tags
}

resource "aws_iam_policy" "aws_lambda_xray_write_only_access" {
  name        = substr("${module.label.id}-aws-lambda-xray-write-only-access", 0, 127)
  path        = "/"
  description = "Customer managed version of AWSXrayWriteOnlyAccess"

  policy = data.aws_iam_policy.AWSXrayWriteOnlyAccess.policy
  tags   = var.tags
}

###################################################################
# Lambda
###################################################################

# sce_parameter_parser

resource "aws_iam_role" "sce_parameter_parser" {
  name = substr("${module.label.id}-lambda-parameter-parser", 0, 63)

  assume_role_policy = templatefile("${path.module}/iam/trust-policies/trust.json.tftpl", {
    service_principals = "\"lambda.amazonaws.com\""
  })
  tags = var.tags
}

resource "aws_iam_role_policy" "sce_parameter_parser" {
  name = substr("${module.label.id}-lambda-parameter-parser", 0, 127)
  role = aws_iam_role.sce_parameter_parser.id

  policy = templatefile("${path.module}/iam/role-policies/lambda/sce_parameter_parser.json.tftpl", {
    aws_sqs_queue_sce_dlq_arn = aws_sqs_queue.sce_dlq.arn
  })
}

resource "aws_iam_role_policy_attachment" "sce_parameter_parser" {
  count = length(local.lambda.lambda_managed_policies)

  role       = aws_iam_role.sce_parameter_parser.name
  policy_arn = local.lambda.lambda_managed_policies[count.index]
}