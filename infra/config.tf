terraform {
  backend "s3" {
    bucket = "terraform-state-demoapi"
    key    = "terraform"
    region = "us-east-1"
  }
}