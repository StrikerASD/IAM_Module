provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_service_account" "service_accounts" {
  for_each = var.service_accounts
  account_id   = each.key
  display_name = each.value
}