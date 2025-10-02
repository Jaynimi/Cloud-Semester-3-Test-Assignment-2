terraform {
  backend "s3" {
    bucket         = "project-bedrock-tfstate-<144205544946>"
    key            = "global/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "project-bedrock-locks"
    encrypt        = true
  }
}
