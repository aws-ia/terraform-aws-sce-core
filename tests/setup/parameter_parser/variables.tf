# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

variable "stage" {
  description = "Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'."
  type        = string
  default     = null
}

variable "label_id_order" {
  description = "ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique"
  type        = list(string)
  default     = ["name", "namespace", "stage"]
}

variable "tags" {
  description = "Map of tags to apply to resources deployed by this solution."
  type        = map(any)
  default     = null
}