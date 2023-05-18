
resource "aws_s3_bucket" "web-s3" {
  bucket = "web-s3.com"
}
resource "aws_s3_bucket_website_configuration" "web-s3-website" {
  bucket = aws_s3_bucket.web-s3.id

  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "index.html"
  }
}
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.web-s3.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "my_bucket_policy" {
  bucket = aws_s3_bucket.web-s3.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = [
          "s3:GetObject"
        ]
        Resource = [
          "${aws_s3_bucket.web-s3.arn}/*"
        ]
      }
    ]
  })
}
