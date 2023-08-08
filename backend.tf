terraform {
  backend "s3" {
    bucket = "ermeticcustomer2-terraform"
    key    = "prod"
    region = "us-east-1"
  }
}
