variable "lambda_sce_parameter_parser_s3_bucket" {
  description = "S3 bucket name containting the Lambda source code .zip file"
  type        = string
}

variable "lambda_sce_parameter_parser_s3_key" {
  description = "S3 bucket key of the Lambda source code .zip file"
  type        = string
}
