terraform {
  required_version = ">=1.0.0"
  # backend "s3" {
  #   bucket = ""
  #   key    = ""
  #   region = ""
  # }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.46.0"
    }
    ansible = {
      source  = "ansible/ansible"
      version = "1.3.0"
    }
  }
}
