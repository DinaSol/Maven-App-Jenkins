
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



resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.web-s3.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
 statement {
    actions = [
      "s3:*",
    ]

    resources = [
      aws_s3_bucket.example.arn,
      "${aws_s3_bucket.web-s3.arn}/*",
    ]
  }
}
