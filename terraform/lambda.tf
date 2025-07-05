resource "aws_lambda_function" "sqs_handler" {
  function_name = "sqs-listener"
  role          = local.lab_role_arn
  runtime       = "python3.9"
  handler       = "lambda_handler.lambda_handler"
  filename      = var.lambda_src_file

  environment {
    variables = {
      API_GATEWAY_URL = local.api_gateway_url
    }
  }
}

resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn = local.sqs_queue_arn
  function_name    = aws_lambda_function.sqs_handler.arn
  batch_size       = 1
  enabled          = true
}
