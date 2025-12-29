# Backend configuration for Terraform state
# 1. Run bootstrap: cd ../../bootstrap && terraform init && terraform apply
# 2. Copy the bucket name from the output
# 3. Replace <BUCKET_NAME> below with the actual bucket name
# 4. Uncomment and run: terraform init -migrate-state

terraform {
  backend "s3" {
    bucket         = "ecs-tc-tfstate-d13b0082"
    key            = "ecs-threat-composer/dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "ecs-threat-composer-terraform-locks"
  }
}
