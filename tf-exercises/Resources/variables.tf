provider "random" {}

resource "random_string" "unique_id" {
  length  = 16
  special = false
}

output "unique_id" {
  value = random_string.unique_id.result
}
