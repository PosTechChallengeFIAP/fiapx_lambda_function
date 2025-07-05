resource "aws_lambda_function" "sqs_handler" {
  function_name = "sqs-listener"
  role          = local.lab_role_arn
  runtime       = "python3.9"
  handler       = "lambda_handler.lambda_handler"
  filename      = "../lambda.zip"

  environment {
    variables = {
      API_GATEWAY_URL = var.api_gateway_url
    }
  }
}

resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn = var.sqs_queue_arn
  function_name    = aws_lambda_function.sqs_handler.arn
  batch_size       = 1
  enabled          = true
}
