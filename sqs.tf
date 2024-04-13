# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

resource "aws_sqs_queue" "sce_provision_queue" {

  name                              = local.service_catalog.sqs_provision_queue_name
  kms_master_key_id                 = aws_kms_alias.sce.name
  visibility_timeout_seconds        = 240
  kms_data_key_reuse_period_seconds = 300
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.sce_dlq.arn
    maxReceiveCount     = 1
  })

  tags = local.tags
}


resource "aws_sqs_queue" "sce_termination_queue" {
  name                              = local.service_catalog.sqs_termination_queue_name
  kms_master_key_id                 = aws_kms_alias.sce.name
  visibility_timeout_seconds        = 240
  kms_data_key_reuse_period_seconds = 300
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.sce_dlq.arn
    maxReceiveCount     = 1
  })

  tags = local.tags
}

resource "aws_sqs_queue" "sce_update_queue" {
  name                              = local.service_catalog.sqs_update_queue_name
  kms_master_key_id                 = aws_kms_alias.sce.name
  visibility_timeout_seconds        = 240
  kms_data_key_reuse_period_seconds = 300
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.sce_dlq.arn
    maxReceiveCount     = 1
  })

  tags = local.tags
}


resource "aws_sqs_queue" "sce_dlq" {
  name                              = local.service_catalog.sqs_dlq_name
  kms_master_key_id                 = aws_kms_alias.sce.name
  kms_data_key_reuse_period_seconds = 300

  tags = local.tags
}


resource "aws_sqs_queue_policy" "sce_provision_queue" {
  queue_url = aws_sqs_queue.sce_provision_queue.id
  policy = templatefile("${path.module}/iam/resource-policies/sqs/policy.json.tftpl", {
    aws_sqs_queue_sce_provision_queue_arn   = aws_sqs_queue.sce_provision_queue.arn
    aws_sqs_queue_sce_termination_queue_arn = aws_sqs_queue.sce_termination_queue.arn
    aws_sqs_queue_sce_update_queue_arn      = aws_sqs_queue.sce_update_queue.arn
    aws_kms_key_sce_arn                     = aws_kms_key.sce.arn
  })
}

resource "aws_sqs_queue_policy" "sce_termination_queue" {
  queue_url = aws_sqs_queue.sce_termination_queue.id
  policy = templatefile("${path.module}/iam/resource-policies/sqs/policy.json.tftpl", {
    aws_sqs_queue_sce_provision_queue_arn   = aws_sqs_queue.sce_provision_queue.arn
    aws_sqs_queue_sce_termination_queue_arn = aws_sqs_queue.sce_termination_queue.arn
    aws_sqs_queue_sce_update_queue_arn      = aws_sqs_queue.sce_update_queue.arn
    aws_kms_key_sce_arn                     = aws_kms_key.sce.arn
  })
}

resource "aws_sqs_queue_policy" "sce_update_queue" {
  queue_url = aws_sqs_queue.sce_update_queue.id
  policy = templatefile("${path.module}/iam/resource-policies/sqs/policy.json.tftpl", {
    aws_sqs_queue_sce_provision_queue_arn   = aws_sqs_queue.sce_provision_queue.arn
    aws_sqs_queue_sce_termination_queue_arn = aws_sqs_queue.sce_termination_queue.arn
    aws_sqs_queue_sce_update_queue_arn      = aws_sqs_queue.sce_update_queue.arn
    aws_kms_key_sce_arn                     = aws_kms_key.sce.arn
  })
}