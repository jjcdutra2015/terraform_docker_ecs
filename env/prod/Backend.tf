terraform {
  backend "s3" {
    bucket = "terraform-state-jjcdutra"
    key    = "Prod/terraform.tfstate"
    region = "us-west-2"
  }
}
