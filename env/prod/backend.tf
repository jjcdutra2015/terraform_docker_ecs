terraform {
  backend "s3" {
    bucket = "terraform-state-jjcd"
    key    = "Prod/terraform.tfstate"
    region = "us-west-2"
  }
}
