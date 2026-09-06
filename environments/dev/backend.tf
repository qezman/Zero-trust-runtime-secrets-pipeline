terraform {
  backend "s3" {
    bucket  = "zero-trust-terraform-state-722965867897"
    key     = "zero-trust-secrets-pipeline/dev/terraform.tfstate"
    region  = "us-east-1"
    profile = "ztsp-deployer"
    encrypt      = true
    use_lockfile = true
  }
}
