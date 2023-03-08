terraform {

  required_version = ">1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_ec2_host" "test" {
  instance_type     = "c5.18xlarge"
  availability_zone = "us-west-2a"
  host_recovery     = "on"
  auto_placement    = "on"
}

resource "aws_resourcegroups_group" "test" {
    name = "test-group"
    resource_query {
      query = <<JSON
      {
        "ResourceTypeFilters": ["AWS::AllSupported"],
        "TagFilters": [
          {
            "Key": "App",
            "Values": ["aws-ec2"]
          }
        ]
      }
      JSON
    }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    App = "aws-ec2"
  }
}
