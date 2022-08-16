terraform {
  backend "s3" {
    bucket = "terraform-projects-bk"
    key    = "lambda-pokemon-tf/iam/terraform.tfstate"
    region = "us-east-1"
  }
}