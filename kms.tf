# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

#tfsec:ignore:aws-kms-auto-rotate-keys KMS Key rotation is optional, if dictated by customer policies
resource "aws_kms_key" "sce" {
  #checkov:skip=CKV_AWS_7:KMS Key rotation is optional, if dictated by customer policies

  description = "KMS key for Service Catalog Engine Core"
  policy = templatefile("${path.module}/iam/resource-policies/kms/sce.json.tftpl", {
    data_aws_caller_identity_current_account_id = data.aws_caller_identity.current.account_id
    data_aws_region_current_name                = data.aws_region.current.name
    data_aws_partition_current_id               = data.aws_partition.current.id
  })
  tags = local.tags
}

resource "aws_kms_alias" "sce" {
  name          = "alias/sce"
  target_key_id = aws_kms_key.sce.key_id
}