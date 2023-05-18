resource "aws_s3_bucket" "web-s3" {
  bucket = "web-s3.com"

  tags = {
    Name        = "web-s3"
  }
}

resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.web-s3.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
  }


resource "aws_s3_bucket_policy" "example_bucket_policy" {
  bucket = "web-s3.com"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Id": "Policy1679932274230",
    "Statement": [
        {
            "Sid": "Stmt1679932268557",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "aws_s3_bucket.web-s3.id/*"
        }
    ]
})
}
