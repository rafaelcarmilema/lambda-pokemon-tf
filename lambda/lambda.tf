resource "aws_lambda_function" "test_lambda" {
  # If the file is not in the current working directory you will need to include a 
  # path.module in the filename.
  filename      = "../appcode/bundle/my_bundle.zip"
  function_name = "lambda_function_pokemon"
  role          = module.lib.lambda_role
  handler       = "main.lambda_handler"
  description = "GET request to pokemon api and send an email via SNS to sub users with random pokemon facts"
  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256("../appcode/bundle/my_bundle.zip")

  runtime = "python3.8"

#   environment {
#     variables = {
#       foo = "bar"
#     }
#   }
}

resource "aws_lambda_function_event_invoke_config" "sns_pub" {
  function_name = aws_lambda_function.test_lambda.function_name

  destination_config {
    # on_failure {
    # }

    on_success {
      destination = "arn:aws:sns:us-east-1:205758311321:pokemon-fun-facts-topic"
    }
  }
}