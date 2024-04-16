# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_region" "current" {}

######################################
# IAM Policies
######################################

# tflint-ignore: terraform_naming_convention
data "aws_iam_policy" "AWSLambdaBasicExecutionRole" {
  name = "AWSLambdaBasicExecutionRole"
}

# tflint-ignore: terraform_naming_convention
data "aws_iam_policy" "AWSLambdaVPCAccessExecutionRole" {
  name = "AWSLambdaVPCAccessExecutionRole"
}

# tflint-ignore: terraform_naming_convention
data "aws_iam_policy" "AWSXrayWriteOnlyAccess" {
  name = "AWSXrayWriteOnlyAccess"
}
