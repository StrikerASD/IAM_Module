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
  description = "Map of service account IDs to their display names and roles."
  type = map(object({
    display_name = string
    roles        = list(string)
  }))
}
