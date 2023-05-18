
resource "aws_s3_bucket" "web-s3" {
  bucket = "web-s3.com"
  acl    = "public-read"
  website {
    index_document = "index.html"
    error_document = "index.html"
  }
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
