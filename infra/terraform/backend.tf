terraform {
  backend "s3" {
    bucket         = "inegi-tfstate"
    key            = "terraform/inegi-infra.tfstate"
    region         = "us-east-1"
    use_lockfile = true
    encrypt        = true
  }
}
