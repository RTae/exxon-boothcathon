resource "google_bigquery_dataset" "dataset" {
  project = var.project_id
  location = var.location
  dataset_id                  = var.name
  friendly_name               = var.display_name
  description                 = var.description
  default_table_expiration_ms = var.default_table_expiration_ms

  dynamic "access" {
    for_each = var.access
    content {
      role = access.value.role
      user_by_email = access.value.email
    }
  }
}