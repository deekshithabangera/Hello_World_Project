resource "random_string" "random" {
  length           = 16
  special          = false
  lower            = true
  upper            = false
  number           = false
}

resource "aws_s3_bucket" "example" {
  bucket = "deek-bucket-${random_string.random.result}"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}