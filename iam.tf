data "aws_iam_policy_document" "this" {


  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:*"]
    effect    = "Allow"
  }

  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "this" {
  name        = "${var.service_name}-lambda-basic-execution-policy"
  description = "IAM policy for basic execution role for Lambda"
  policy      = data.aws_iam_policy_document.this.json
}

resource "aws_iam_role" "this" {
  name               = "${var.service_name}-lambda-exec-role"
  assume_role_policy = aws_iam_role_policy.assume_role.policy
}


resource "aws_iam_role_policy" "assume_role" {
  name = "${var.service_name}-lambda-assume-role"
  role = aws_iam_role.this.name
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}
resource "aws_iam_role_policy_attachment" "lambda_execution_role" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


