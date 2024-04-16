## NOTE: This is the minimum mandatory test
# run at least one test using the ./examples directory as your module source
# create additional *.tftest.hcl for your own unit / integration tests
# use tests/*.auto.tfvars to add non-default variables

run "setup" {
  command = apply
  module {
    source = "./tests/setup/parameter_parser"
  }
}

run "mandatory_plan_basic" {
  command = plan
  module {
    source = "./examples/basic"
  }

  variables {
    lambda_sce_parameter_parser_s3_bucket = run.setup.lambda_sce_parameter_parser_s3_bucket
    lambda_sce_parameter_parser_s3_key    = run.setup.lambda_sce_parameter_parser_s3_key
  }
}

// run "mandatory_apply_basic" {
//   command = apply
//   module {
//     source = "./examples/basic"
//   }

//   variables {
//     lambda_sce_parameter_parser_s3_bucket = run.setup.lambda_sce_parameter_parser_s3_bucket
//     lambda_sce_parameter_parser_s3_key = run.setup.lambda_sce_parameter_parser_s3_key
//   }
// }
