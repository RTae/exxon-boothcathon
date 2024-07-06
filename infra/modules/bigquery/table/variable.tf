variable "project_id" {
  type        = string
  description = "The GCP project ID"
}

variable "dataset_name" {
  type        = string
  description = "The name of the bigquery dataset"
}

variable "name" {
  type        = string
  description = "The name of the bigquery table"
}

variable "description" {
  type        = string
  description = "The description of the bigquery table"
}

variable "time_partitioning" {
  type        = list(object({
    type          = string
    field = string
  }))
  description = "The time partitioning of the bigquery table"
  default     = []
}

variable "file_path" {
  type        = string
  description = "The schema file for a bigquery table"
}

variable "view_query_path" {
  type        = string
  description = "The query file path for a bigquery view"
  default = null
}