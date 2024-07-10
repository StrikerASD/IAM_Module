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
  for_each = { for k, v in var.service_accounts : k => v.roles }

  project = var.project_id
  role    = each.value[0]
  member  = "serviceAccount:${google_service_account.service_accounts[each.key].email}"

  lifecycle {
    ignore_changes = [role] # Prevents Terraform from recreating the resource when roles change
  }

  dynamic "roles" {
    for_each = range(length(each.value))

    content {
      role   = each.value[roles.value]
      member = "serviceAccount:${google_service_account.service_accounts[each.key].email}"
    }
  }
}