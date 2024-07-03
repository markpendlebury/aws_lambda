resource "aws_lambda_function" "this" {
  function_name    = "${var.service_name}-lambda"
  package_type     = var.package_type
  s3_bucket        = var.package_type == "Zip" ? var.s3_bucket : null
  s3_key           = var.package_type == "Zip" ? var.s3_key : null
  filename         = var.package_type == "Zip" ? null : var.filename
  handler          = var.lambda_handler
  runtime          = var.runtime
  timeout          = var.timeout
  memory_size      = var.memory_size
  role             = aws_iam_role.lambda_exec.arn
  source_code_hash = var.source_code_hash

  environment {
    variables = var.environment
  }
}
