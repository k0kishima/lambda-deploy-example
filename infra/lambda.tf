data "archive_file" "lambda_zip" {
  type        = "zip"
  output_path = "${path.module}/lambda_function.zip"

  source {
    content  = "def handler(event, context):\n    print('Hello World')\n    return 'Hello World'"
    filename = "main.py"
  }
}

resource "aws_s3_object" "lambda_code" {
  bucket = aws_s3_bucket.lambda_code_bucket.bucket
  key    = "lambda_function.zip"
  source = data.archive_file.lambda_zip.output_path

  etag = filemd5(data.archive_file.lambda_zip.output_path)
}

resource "aws_lambda_function" "this" {
  function_name = "DeployExampleLambda"

  s3_bucket = aws_s3_bucket.lambda_code_bucket.bucket
  s3_key    = aws_s3_object.lambda_code.key

  handler = "main.handler"
  runtime = "python3.10"
  role    = aws_iam_role.lambda_execution_role.arn

  timeout = 30
}
