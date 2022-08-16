terraform {
  backend "s3" {
    bucket = "terraform-projects-bk"
    key    = "lambda-pokemon-tf/terraform.tfstate"
    region = "us-east-1"
  }
}