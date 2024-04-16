# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

############################################################################################################
# sce_terraform_state
############################################################################################################

resource "aws_s3_bucket" "sce_terraform_state" {
  #checkov:skip=CKV2_AWS_62:event notification is not required
  #checkov:skip=CKV2_AWS_61:lifecycle configuration is not required
  #checkov:skip=CKV_AWS_144:cross-region replication is not required
  #checkov:skip=CKV_AWS_18:access logging is not required
  bucket = local.s3.sce_terraform_state.bucket
  tags   = var.tags
}

resource "aws_s3_bucket_versioning" "sce_terraform_state" {

  bucket = aws_s3_bucket.sce_terraform_state.id
  versioning_configuration {
    status = local.s3.sce_terraform_state.versioning_configuration_status
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sce_terraform_state" {

  bucket = aws_s3_bucket.sce_terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_alias.tfc.target_key_arn
      sse_algorithm     = local.s3.sce_terraform_state.sse_algorithm
    }
  }
}

resource "aws_s3_bucket_public_access_block" "sce_terraform_state" {

  bucket = aws_s3_bucket.sce_terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
