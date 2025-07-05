data "terraform_remote_state" "sqs_infra" {
  backend = "s3"
  config = {
    bucket = "fiapx-terraform-state-bucket"
    key    = "cluster/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "api_infra" {
  backend = "s3"
  config = {
    bucket = "fiapx-terraform-state-bucket"
    key    = "integration/terraform.tfstate"
    region = "us-east-1"
  }
}

data "aws_iam_role" "default" {
  name = "LabRole"
}

locals {
  sqs_queue_arn         = data.terraform_remote_state.sqs_infra.outputs.sqs_queue_arn
  api_gateway_url       = data.terraform_remote_state.api_infra.outputs.video_processor_api_gateway_url
  lab_role_arn          = data.aws_iam_role.default.arn
}