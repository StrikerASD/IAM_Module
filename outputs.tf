output "service_account_emails" {
  description = "The emails of the created service accounts."
  value       = { for sa in google_service_account.service_accounts : sa.key => sa.value.email }
}
