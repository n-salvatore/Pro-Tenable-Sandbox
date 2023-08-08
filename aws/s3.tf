resource "aws_s3_bucket" "data" {
  # bucket is public
  # bucket is not encrypted
  # bucket does not have access logs
  # bucket does not have versioning
  bucket        = "${local.resource_prefix.value}-data"
  force_destroy = true
  tags = {
    Name        = "${local.resource_prefix.value}-data"
    Environment = local.resource_prefix.value
  }
}

resource "aws_s3_object" "data_object" {
  bucket = aws_s3_bucket.data.id
  key    = "customer-master.xlsx"
  source = "${path.module}/resources/customer-master.xlsx"
  tags = {
    Name        = "${local.resource_prefix.value}-customer-master"
    Environment = local.resource_prefix.value
  }
}

resource "aws_s3_bucket" "financials" {
  # bucket is not encrypted
  # bucket does not have access logs
  # bucket does not have versioning
  bucket        = "${local.resource_prefix.value}-financials"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "financials_bucket_acl" {
  bucket = aws_s3_bucket.financials.id
  acl    = "private"
}

resource "aws_s3_bucket" "operations" {
  # bucket is not encrypted
  # bucket does not have access logs
  bucket        = "${local.resource_prefix.value}-operations"
  force_destroy = true
  tags = {
    Name        = "${local.resource_prefix.value}-operations"
    Environment = local.resource_prefix.value
  }
}

resource "aws_s3_bucket_versioning" "operations_bucket_versioning" {
  bucket = aws_s3_bucket.operations.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "operations_bucket_acl" {
  bucket = aws_s3_bucket.operations.id
  acl    = "private"
}

resource "aws_s3_bucket" "data_science" {
  # bucket is not encrypted
  bucket        = "${local.resource_prefix.value}-data-science"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "data_science_bucket_versioning" {
  bucket = aws_s3_bucket.data_science.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_logging" "data_science_logging" {
  bucket        = aws_s3_bucket.data_science.id
  target_bucket = aws_s3_bucket.logs.id
  target_prefix = "log/"
}

resource "aws_s3_bucket_acl" "data_science_bucket_acl" {
  bucket = aws_s3_bucket.data_science.id
  acl    = "private"
}

resource "aws_s3_bucket" "logs" {
  bucket        = "${local.resource_prefix.value}-logs"
  force_destroy = true
  tags = {
    Name        = "${local.resource_prefix.value}-logs"
    Environment = local.resource_prefix.value
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs_server_side_encryption" {
  bucket = aws_s3_bucket.logs.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.logs_key.arn
    }
  }
}

resource "aws_s3_bucket_versioning" "logs_bucket_versioning" {
  bucket = aws_s3_bucket.logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "logs_bucket_acl" {
  bucket = aws_s3_bucket.logs.id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket" "internal_data" {
  bucket        = "${local.resource_prefix.value}-internal-data"
  force_destroy = true
  tags = {
    Name        = "${local.resource_prefix.value}-internal-data"
    Environment = local.resource_prefix.value
  }
}

resource "aws_s3_bucket_policy" "internal_data_policy" {
  bucket = aws_s3_bucket.internal_data.id
  policy = data.aws_iam_policy_document.public_access_policy.json
}

data "aws_iam_policy_document" "public_access_policy" {
    statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.internal_data.arn,
      "${aws_s3_bucket.internal_data.arn}/*",
    ]
  }
}

module "reports-analytics-bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  version = "3.6.1"

  bucket = "${local.resource_prefix.value}-reports-analytics"

  grant = [{
    type       = "Group"
    permission = "READ_ACP"
    uri         = "http://acs.amazonaws.com/groups/global/AllUsers"
  }]
}