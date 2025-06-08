
data "aws_availability_zones" "available" {
  state = "available"
}

resource "random_string" "id" {
  length  = 5
  special = false
  upper = false
  numeric = false
}

# Test with s3 bucket
resource "aws_s3_bucket" "example" {
  bucket = "my-new-tf-test-bucket-${random_string.id.result}"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}