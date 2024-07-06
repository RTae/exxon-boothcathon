resource "google_bigquery_table" "table" {
  project = var.project_id
  deletion_protection=false

  dataset_id = var.dataset_name
  table_id   = var.name
  description = var.description

  dynamic "time_partitioning" {
    for_each = var.time_partitioning
    content {
      type = time_partitioning.value.type
      field = time_partitioning.value.field
    }
  }

  schema = file(var.file_path)

  dynamic "view" {
    for_each = var.view_query_path != null ? [file(var.view_query_path)] : []
    content {
      query = view.value
      use_legacy_sql = false
    }
  }
}