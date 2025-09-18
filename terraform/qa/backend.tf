terraform {
  backend "s3" {
    # TODO: Replace REPO_NAME with your actual repository name
    bucket = "terraform-state-REPO_NAME"
    key    = "qa/terraform.tfstate"
    region = "us-west-2"
    
    # Enable state locking with DynamoDB
    dynamodb_table = "terraform-locks-REPO_NAME"
    encrypt        = true
  }
}