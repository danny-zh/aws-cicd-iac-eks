
data "aws_availability_zones" "available" {
  state = "available"
}

resource "random_string" "id" {
  length  = 4
  special = false
  upper = false
  numeric = false
}

# Test with s3 bucket
resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket-${random_string.id.result}"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}