# aws_lambda
A basic aws lambda function module thats doex excatly what i want how i want 



usage example: 

```
module "lambda" {
  source = "git@github.com:markpendlebury/aws_lambda.git"

  service_name   = "my_lambda_function"
  timeout        = 30
  memory_size    = 128
  runtime        = "python3.8"
  s3_bucket      = aws_s3_bucket.lambda_bucket.bucket
  s3_key         = aws_s3_object.object.key
  filename       = "lambda.zip"
  lambda_handler = "lambda_function.lambda_handler"
}

resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "my-lambda-function-bucket"
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.lambda_bucket.bucket
  key    = "lambda.zip"
  source = data.archive_file.lambda_zip.output_path
}


data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "../src"
  output_path = "../lambda.zip"
}
```