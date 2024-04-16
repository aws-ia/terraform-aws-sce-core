module "sce_core" {
  source = "../.."

  lambda_sce_parameter_parser_s3_bucket     = var.lambda_sce_parameter_parser_s3_bucket
  lambda_sce_parameter_parser_s3_key        = var.lambda_sce_parameter_parser_s3_key
  lambda_sce_parameter_parser_architectures = ["arm64"]
  lambda_sce_parameter_parser_handler       = "bootstrap"
  lambda_sce_parameter_parser_runtime       = "provided.al2023"
}