variable "project_id" {
  type        = string
  description = "The GCP project ID"
}

variable "location" {
  type        = string
  description = "The Region of the bigquery dataset"
  default     = "asia-southeast1"
}

variable "name" {
  type        = string
  description = "The name of the bigquery dataset"
}

variable "display_name" {
  type        = string
  description = "The display name of the bigquery dataset"
}

variable "description" {
  type        = string
  description = "The description of the bigquery dataset"
}

variable "default_table_expiration_ms" {
  type        = number
  description = "The default table expiration"
  default     = null
}

variable "access" {
  type        = list(object({
    role          = string
    email = string
  }))
  description = "The access of the bigquery dataset"
  default     = []
}

