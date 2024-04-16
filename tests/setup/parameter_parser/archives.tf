# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

############################################################################################################
# terraform_parameter_parser
############################################################################################################
data "archive_file" "terraform_parameter_parser" {
  type        = "zip"
  source_dir  = "${path.module}/src/golang/terraform-parameter-parser"
  output_path = "${local.archive_path}/terraform-parameter-parser.zip"
}

resource "aws_s3_object" "terraform_parameter_parser" {
  key        = "build/src/terraform-parameter-parser.zip"
  bucket     = aws_s3_bucket.sce_terraform_state.id
  source     = data.archive_file.terraform_parameter_parser.output_path
  kms_key_id = aws_kms_alias.tfc.target_key_arn
}

