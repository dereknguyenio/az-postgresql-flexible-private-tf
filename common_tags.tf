// common_tags.tf
locals {
  common_tags = {
    "Environment"  = "Dev"
    "Owner"        = "IT Department"
    "CostCenter"   = "12345"
    "ManagedBy"    = "Terraform"
    "GitHubRepo"   = "https://github.com/dereknguyenio/your_repo"
    "UpdatedDate"  = timestamp()
  }
}
