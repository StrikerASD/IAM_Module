variable "project_id" {
  description = "The ID of the project in which to create the service accounts."
  type        = string
}

variable "region" {
  description = "The region where resources will be deployed."
  type        = string
  default     = "europe-west3"
}

variable "service_accounts" {
  type = map(string)
  description = "Map of service accounts and display_names to be created. Key is service account and value is display_name"
}