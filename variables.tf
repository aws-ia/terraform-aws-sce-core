# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

#########################################
# Solution-Level Variables
#########################################

variable "tags" {
  description = "Map of tags to apply to resources deployed by this solution."
  type        = map(any)
  default     = null
}

#########################################
# Label / Naming Variables
#########################################

variable "label_id_order" {
  description = "ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique"
  type        = list(string)
  default     = ["name", "namespace", "stage"]
}

variable "stage" {
  description = "Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'."
  type        = string
  default     = null
}

#########################################
# Cloudwatch Variables
#########################################

variable "cloudwatch_log_group_retention" {
  description = "Amount of days to keep CloudWatch Log Groups for Lambda functions. 0 = Never Expire"
  type        = string
  default     = "0"
  validation {
    condition     = contains(["1", "3", "5", "7", "14", "30", "60", "90", "120", "150", "180", "365", "400", "545", "731", "1827", "3653", "0"], var.cloudwatch_log_group_retention)
    error_message = "Valid values for var: cloudwatch_log_group_retention are (1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0)."
  }
}

#########################################
# Lambda Variables
#########################################

###########################################################################################
# sce_parameter_parser #
###########################################################################################

variable "lambda_sce_parameter_parser_architectures" {
  description = "Instruction set architecture for your Lambda function."
  type        = list(string)
  validation {
    condition = alltrue([
      for v in var.lambda_sce_parameter_parser_architectures : contains(["arm64", "x86_64"], v)
    ])
    error_message = "Valid values for var: lambda_sce_parameter_parser_architectures are ('arm64', 'x86_64')."
  }
}

variable "lambda_sce_parameter_parser_description" {
  description = "Description of what your Lambda Function does"
  type        = string
  default     = "Parses parameters - Invoked by Service Catalog"
}

variable "lambda_sce_parameter_parser_handler" {
  type        = string
  description = "Function entrypoint in your code."
  validation {
    condition     = length(var.lambda_sce_parameter_parser_handler) <= 128
    error_message = "Lambda handler name must be less than 128 characters long."
  }
}

variable "lambda_sce_parameter_parser_memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime"
  type        = number
  default     = 1024
  validation {
    condition = (
      var.lambda_sce_parameter_parser_memory_size >= 128 &&
      var.lambda_sce_parameter_parser_memory_size <= 10240
    )
    error_message = "Lambda memory size must be between 128 and 10240 MB."
  }
}

variable "lambda_sce_parameter_parser_runtime" {
  description = "Identifier of the function's runtime."
  type        = string
  validation {
    condition     = contains(["nodejs20.x", "nodejs18.x", "nodejs16.x", "nodejs14.x", "python3.11", "python3.10", "python3.9", "python3.8", "python3.7", "java21", "java17", "java11", "java8.al2", "java8", "dotnet7", "dotnet6", "go1.x", "ruby3.2", "ruby2.7", "provided.al2023", "provided.al2", "provided"], var.lambda_sce_parameter_parser_runtime)
    error_message = "Valid values for var: lambda_sce_parameter_parser_runtime are (nodejs20.x, nodejs18.x, nodejs16.x, nodejs14.x, python3.11,python3.10,python3.9,python3.8,python3.7, java21, java17, java11,java8.al2,java8,dotnet7,dotnet6,go1.x,ruby3.2,ruby2.7,provided.al2023,provided.al2,provided)."
  }
}

variable "lambda_sce_parameter_parser_s3_bucket" {
  description = "S3 bucket name containting the Lambda source code .zip file"
  type        = string
}

variable "lambda_sce_parameter_parser_s3_key" {
  description = "S3 bucket key of the Lambda source code .zip file"
  type        = string
}

variable "lambda_sce_parameter_parser_timeout" {
  description = "Amount of time your Lambda Function has to run in seconds."
  type        = number
  default     = 100
  validation {
    condition = (
      var.lambda_sce_parameter_parser_timeout >= 1 &&
      var.lambda_sce_parameter_parser_timeout <= 900
    )
    error_message = "Lambda timout must be between 1 and 900 seconds."
  }
}

#########################################
# VPC Variables
#########################################

variable "vpc_id" {
  type        = string
  description = "VPC ID to use if leveraging an existing VPC for the solution."
  default     = null
}

variable "vpc_private_subnet_ids" {
  type        = list(string)
  description = "Required if `vpc_id` is specified. List of private subnets to use in the provided vpc_id"
  default     = null
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "Required if `vpc_id` is specified. List of security groups to use in the provided vpc_id"
  default     = null
}
