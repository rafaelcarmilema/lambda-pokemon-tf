resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
resource "aws_iam_role_policy" "test_policy" {
  name = "test_policy"
  role = aws_iam_role.iam_for_lambda.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
        "Sid": "Stmt1660873417093",
        "Action": [
            "ssm:PutParameter"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:lambda:us-east-1:205758311321:function:lambda_function_pokemon"
        }
      ]
    }
  EOF
}
output "lambda_role" {
  value = aws_iam_role.iam_for_lambda.arn
}