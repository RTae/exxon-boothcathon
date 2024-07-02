variable project_id {
  type        = string
  description = "GCP Project ID"
}

variable location {
  type        = string
  description = "GCP default location"
}

variable "access_members" {
  type = list(
    object({
      role            = string
      email   = string
    })
  )
  description  = "BQ access members"
  default      = []
}