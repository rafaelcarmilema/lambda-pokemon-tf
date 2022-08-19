terraform {
  backend "s3" {
    bucket = "terraform-projects-bk"
    key    = "lambda-pokemon-tf/sns/terraform.tfstate"
    region = "us-east-1"
    //profile ="rafaelcarmilema"
  }
}
module "lib" {
  source = "../lib"
}
