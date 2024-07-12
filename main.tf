provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_service_account" "service_accounts" {
  for_each = var.service_accounts
  account_id   = each.key
  display_name = each.value
}

resource "google_project_iam_member" "service_account_role_bindings" {
  for_each = var.roles
  role   = each.value
  member = each.key
}
