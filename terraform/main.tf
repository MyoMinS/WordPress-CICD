terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket = "terraform-state-file-store-mms"
    key = "wordpress_cicd.tfstate"
    region = "ap-southeast-1"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

module "autoscaling" {
  source = "./module/autoscaling"
  asg_count = 1
}

module "codedeploy" {
  source = "./module/codedeploy"
  asg_resource = module.autoscaling.resource
}
