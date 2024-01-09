# This line starts a block where you can specify the backend. The backend determines how Terraform loads and stores state. The "local" backend stores state on the local filesystem.
terraform {
  backend "local" {
  }
}