# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

locals {

  cloudwatch = {
    lambda_log_group_prefix = "/aws/lambda"
  }

  lambda = {
    lambda_managed_policies = local.vpc_deployment ? [aws_iam_policy.aws_lambda_basic_execution.arn, aws_iam_policy.aws_lambda_vpc_access_execution.arn, aws_iam_policy.aws_lambda_xray_write_only_access.arn] : [aws_iam_policy.aws_lambda_basic_execution.arn, aws_iam_policy.aws_lambda_xray_write_only_access.arn]
  }

  region              = data.aws_region.current.name
  region_abbreviation = format("%s%s%s", substr(split("-", local.region)[0], 0, 1), substr(split("-", local.region)[1], 0, 1), substr(split("-", local.region)[2], 0, 1))

  # names are hard-coded to reflect the Service Catalog name requirements
  service_catalog = {
    lambda_parameter_parser_name = "ServiceCatalogExternalParameterParser"
    principal                    = "servicecatalog.amazonaws.com"
    sqs_dlq_name                 = "ServiceCatalogExternalOperationsDLQ"
    sqs_provision_queue_name     = "ServiceCatalogExternalProvisionOperationQueue"
    sqs_termination_queue_name   = "ServiceCatalogExternalTerminateOperationQueue"
    sqs_update_queue_name        = "ServiceCatalogExternalUpdateOperationQueue"

  }
  solution_name = "aws-sce-core"

  tags = merge(
    var.tags,
    {
      "SolutionName" = local.solution_name
  })

  vpc_deployment = var.vpc_id != null ? true : false
}