run "setup" {
  command = apply
  module {
    source = "./tests/setup/parameter_parser"
  }
}

run "sqs_contract_test" {
  command = apply

  variables {
    lambda_sce_parameter_parser_s3_bucket     = run.setup.lambda_sce_parameter_parser_s3_bucket
    lambda_sce_parameter_parser_s3_key        = run.setup.lambda_sce_parameter_parser_s3_key
    lambda_sce_parameter_parser_architectures = ["arm64"]
    lambda_sce_parameter_parser_handler       = "bootstrap"
    lambda_sce_parameter_parser_runtime       = "provided.al2023"
  }

  assert {
    condition     = aws_sqs_queue.sce_provision_queue.name == "ServiceCatalogExternalProvisionOperationQueue"
    error_message = "The Provision SQS queue name must be 'ServiceCatalogExternalProvisionOperationQueue'"
  }

  assert {
    condition     = aws_sqs_queue.sce_termination_queue.name == "ServiceCatalogExternalTerminateOperationQueue"
    error_message = "The Termination SQS queue name must be 'ServiceCatalogExternalTerminateOperationQueue'"
  }

  assert {
    condition     = aws_sqs_queue.sce_update_queue.name == "ServiceCatalogExternalUpdateOperationQueue"
    error_message = "The Update SQS queue name must be 'ServiceCatalogExternalUpdateOperationQueue'"
  }

  assert {
    condition     = aws_lambda_permission.sce_parameter_parser.principal == "servicecatalog.amazonaws.com"
    error_message = "The Lambda parser must allow servicecatalog.amazonaws.com as principal"
  }
}