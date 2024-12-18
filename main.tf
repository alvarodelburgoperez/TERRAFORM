module "iam" {
  source      = "./iam"
  user1_name  = "pepe"
  user2_name  = "juan"
}

# locals
locals {
  common_tags = {
    nombre = "Alvaro Del Burgo Perez"
    iac    = "terraform"
    env    = "Automatización y despliegue"
  }
}

provider "aws" {
  region = "eu-west-1"
}


# data sources
data "aws_caller_identity" "current" {}


resource "aws_s3_bucket" "data_bucket" {
  bucket = "bucket-data-${data.aws_caller_identity.current.account_id}"
  tags   = local.common_tags
}



resource "aws_budgets_budget" "ec2" {
  name              = "budget-ec2-monthly"
  budget_type       = "COST"
  limit_amount      = "25"
  limit_unit        = "USD"
  time_period_end   = "2087-06-15_00:00"
  time_period_start = "2024-11-06_12:00"
  time_unit         = "MONTHLY"

  cost_filter {
    name   = "Service"
    values = ["Amazon Elastic Compute Cloud - Compute"]
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 20
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = [var.email]
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 40
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = [var.email]
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 60
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = [var.email]
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = [var.email]
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = [var.email]
  }

  tags = local.common_tags
}

terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "terraform-infrastructure-242201299422"
    dynamodb_table = "terraform-state-lock-dynamo"
    key            = "terraform.tfstate"
    region         = "eu-west-1"
  }
}
