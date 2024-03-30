terraform {
  backend "s3" {
    bucket         = "deltax-terraform-states"
    key            = "myapp/dev/tfstate"
    region         = "us-east-2"
    dynamodb_table = "Locking"
  }
}

