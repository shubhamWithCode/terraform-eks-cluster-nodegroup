terraform {
  backend "s3" {
    bucket         = "nike-main-bucket"
    key            = "eksNodeClustertfState/state.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "dynamo-db-table-name"
  }
}
