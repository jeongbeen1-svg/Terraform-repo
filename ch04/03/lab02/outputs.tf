# outputs.tf
output "s3bucket" {
  value = {
    (local.s3bucket.name) = {
      bucket = aws_s3_bucket.this.bucket
      arn    = aws_s3_bucket.this.arn
    }
  }
}