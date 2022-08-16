data "terraform_remote_state" "iam_tf" {
  backend = "s3"

  config = {
    bucket = "lambda-pokemon-tf"
    key    = "iam"
    region = "us-east-1"
  }
}

# data "aws_s3_bucket" "iam_role" {
#   bucket = "lambda-pokemon-tf"
# }