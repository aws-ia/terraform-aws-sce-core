locals {
  archive_path = "${path.module}/build-artifacts/"

  s3 = {
    sce_terraform_state = {
      bucket                          = substr("${module.label.id}-${data.aws_caller_identity.current.account_id}-tf-state", 0, 62)
      sse_algorithm                   = "aws:kms"
      versioning_configuration_status = "Enabled"
    }
  }
  solution_name = "aws-sce-tf-community"

  kms = {
    tfc = {
      alias               = "alias/tfc"
      description         = "KMS key for Service Catalog Engine TFC"
      enable_key_rotation = true
    }
  }

  region              = data.aws_region.current.name
  region_abbreviation = format("%s%s%s", substr(split("-", local.region)[0], 0, 1), substr(split("-", local.region)[1], 0, 1), substr(split("-", local.region)[2], 0, 1))
}
