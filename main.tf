provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_service_account" "service_accounts" {
  for_each = var.service_accounts

  account_id   = each.key
  display_name = each.value.display_name
}

resource "google_project_iam_member" "service_account_roles" {
  for_each = { for sa, details in var.service_accounts : sa => details.roles }

  project = var.project_id

  # This creates one iam_member for each role
  member = "serviceAccount:${google_service_account.service_accounts[each.key].email}"
  role   = each.value[0] # We will loop through all roles later
}

resource "google_project_iam_member" "service_account_role" {
  for_each = {
    for sa, details in var.service_accounts : sa => {
      for role in details.roles : "${sa}-${role}" => {
        service_account = sa
        role            = role
      }
    }
  }

  project = var.project_id
  member  = "serviceAccount:${google_service_account.service_accounts[each.value.service_account].email}"
  role    = each.value.role
}

output "service_account_emails" {
  value = { for sa in google_service_account.service_accounts : sa.key => sa.value.email }
}
