
data "aws_caller_identity" "current" {}

variable "company_name" {
  default = "acme"
}

variable "environment" {
  default = "prod"
}

locals {
  resource_prefix = {
    value = "tf-${var.company_name}-${var.environment}"
  }
}

variable "profile" {
  default = "default"
}

variable "region" {
  default = "us-west-2"
}

variable "ami" {
  type    = string
  default = "ami-a0cfeed8"
}

variable "dbname" {
  type        = string
  description = "Name of the Database"
  default     = "db1"
}

variable "db_username" {
  type        = string
  description = "Database username"
  default     = "ermetic"
}


variable "volume_name" {
  type        = string
  description = "volume name"
  default     = "a"
}
variable "password" {
  type        = string
  description = "Database password"
  default     = "Aa1234321Bb"
}

variable "neptune-dbname" {
  type        = string
  description = "Name of the Neptune graph database"
  default     = "neptunedb1"
}
