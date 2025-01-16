terraform {
  required_version = ">=1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.46.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.4.5"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "us_east_1"
}

provider "aws" {
  region = "us-east-2"
  alias  = "us_east_2"
}

provider "aws" {
  region = "eu-west-1"
  alias  = "eu_west_1"
}

provider "aws" {
  region = "eu-west-2"
  alias  = "eu_west_2"
}

provider "aws" {
  region = "ap-south-1"
  alias  = "ap_south_1"
}

provider "aws" {
  region = "ap-northeast-1"
  alias  = "ap_northeast_1"
}

provider "aws" {
  region = "ap-northeast-2"
  alias  = "ap_northeast_2"
}

provider "aws" {
  region = "ap-northeast-3"
  alias  = "ap_northeast_3"
}

provider "aws" {
  region = "ap-southeast-1"
  alias  = "ap_southeast_1"
}

provider "aws" {
  region = "ap-southeast-2"
  alias  = "ap_southeast_2"
}

provider "aws" {
  region = "ca-central-1"
  alias  = "ca_central_1"
}
