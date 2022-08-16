terraform {
  backend "s3" {
    bucket = "terraform-projects-bk"
    key    = "lambda-pokemon-tf/lambda/terraform.tfstate"
    region = "us-east-1"
  }
}
module "lib" {
  source = "../lib"
}
