data "terraform_remote_state" "iam_tf" {
  backend = "s3"

  config = {
    bucket = "terraform-projects-bk"
    key    = "lambda-pokemon-tf/iam/terraform.tfstate"
    region = "us-east-1"
  }
}

output "lambda_role" {
  value = data.terraform_remote_state.iam_tf.outputs.lambda_role
}
# data "aws_s3_bucket" "iam_role" {
#   bucket = "lambda-pokemon-tf"
# }