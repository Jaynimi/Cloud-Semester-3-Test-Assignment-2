terraform {
required_providers {
aws = { source = "hashicorp/aws" }
kubernetes = { source = "hashicorp/kubernetes" }
}
}


provider "aws" {
region = var.aws_region
}