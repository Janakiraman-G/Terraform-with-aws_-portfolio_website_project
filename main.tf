# create an S3 bucket for hosting a static website
resource "aws_s3_bucket" "my_bucket" {
    bucket = var.bucketname
}

resource "aws_s3_bucket_ownership_controls" "name" {
    bucket = aws_s3_bucket.my_bucket.id
    rule{
        object_ownership = "BucketOwnerPreferred"
    }
}

resource "aws_s3_bucket_public_access_block" "name" {
    bucket = aws_s3_bucket.my_bucket.id
    block_public_acls = false
    block_public_policy = false
    ignore_public_acls = false
    restrict_public_buckets = false   
}

resource "aws_s3_bucket_acl" "name" {
    depends_on = [ 
        aws_s3_bucket_ownership_controls.name,
        aws_s3_bucket_public_access_block.name,
     ]

     bucket = aws_s3_bucket.my_bucket.id
     acl    = "public-read" 
}
# upload the index.html file to the S3 bucket
resource "aws_s3_bucket_object" "index" {
    bucket = aws_s3_bucket.my_bucket.id
    key = "index.html"
    source = "index.html"
    acl = "public-read"
    content_type = "text/html"
}

# upload the error.html file to the S3 bucket
resource "aws_s3_bucket_object" "error" {
    bucket = aws_s3_bucket.my_bucket.id
    key = "error.html"
    source = "error.html"
    acl = "public-read"
    content_type = "text/html"
}

resource "aws_s3_bucket_website_configuration" "Website" {
    bucket = aws_s3_bucket.my_bucket.id
    index_document {
      suffix = "index.html"
    }
    error_document {
      key = "error.html"
    }

    depends_on = [ aws_s3_bucket_acl.name ]
  
}