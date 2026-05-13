resource "aws_s3_bucket" "this" {
  bucket = local.s3bucket.bucket

  tags = {
    Name = "${local.namespace}-s3bucket-${local.s3bucket.name}"
  }

  lifecycle {
    prevent_destroy = true
  }
}


resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = local.s3bucket.versioning_configuration.status
  }
}


resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = local.s3bucket.public_access_block.block_public_acls
  block_public_policy     = local.s3bucket.public_access_block.block_public_policy
  ignore_public_acls      = local.s3bucket.public_access_block.ignore_public_acls
  restrict_public_buckets = local.s3bucket.public_access_block.restrict_public_buckets
}
