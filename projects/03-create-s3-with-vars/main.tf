resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name

  tags = {
    Name = "s3-terraform-bucket"
  }
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}
