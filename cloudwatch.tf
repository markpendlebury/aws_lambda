resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${aws_lambda_function.this.function_name}"
  retention_in_days = var.cloudwatch_log_retention
}

resource "aws_cloudwatch_event_rule" "this" {
  count               = var.enable_scheduled_event ? 1 : 0
  name                = "${var.service_name}-schedule"
  description         = "A schedule event rule for ${var.service_name}"
  schedule_expression = var.schedule
}

resource "aws_cloudwatch_event_target" "this" {
  count = var.enable_scheduled_event ? 1 : 0
  rule  = aws_cloudwatch_event_rule.this[0].name
  arn   = aws_lambda_function.this.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda" {
  count         = var.enable_scheduled_event ? 1 : 0
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.this[0].arn
}
