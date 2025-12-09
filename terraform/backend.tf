terraform {
  backend "s3" {
    bucket         = "memos-terraform-state-nourdemo"  
    key            = "memos/terraform.tfstate"
    region         = "eu-west-2"
    encrypt        = true
    dynamodb_table = "memos-terraform-locks" 
  }
}

