output "lambda_sce_parameter_parser_s3_bucket" {
  value = aws_s3_bucket.sce_terraform_state.id
}

output "lambda_sce_parameter_parser_s3_key" {
  value = aws_s3_object.terraform_parameter_parser.key
}