# ------------------------------------------------------------------------------
# Service account
# ------------------------------------------------------------------------------
locals {
  service_account_list = [
    {
      name : "data-pipeline",
      display_name : "Data Pipeline",
      description : "Service account for data pipeline",
      iam_roles : [
        "roles/bigquery.jobUser",
      ],
    },
    {
      name : "cicd-pipeline",
      display_name : "CICD Pipeline",
      description : "Service account for CICD",
      iam_roles : [
        "roles/firebase.admin",
      ],
    },
    {
      name : "dashboard",
      display_name : "Dashboard",
      description : "Service account for dashboard",
      iam_roles : [
        "roles/bigquery.jobUser",
      ],
    }
  ]
}
module "service_account" {
  for_each = { for idx, sa in local.service_account_list : idx => sa }
  source   = "./modules/sa"

  project_id   = var.project_id
  name         = each.value.name
  display_name = each.value.display_name
  description  = each.value.description
  iam_roles    = each.value.iam_roles
}

module "dataset" {

  source = "./modules/bigquery/dataset"

  location   = var.location
  project_id = var.project_id

  name         = var.bq_dataset_name
  display_name = "Analysis"
  description  = "Analysis"

  access = concat(
    [
      {
        role  = "READER"
        email = module.service_account[2].email_sa
      },
    ],
    var.access_members
  )

  depends_on = [
    module.service_account,
  ]
}

locals {
  biq_query_tables = [
    {
      name : "mer",
      description : "Table for MER",
      file_path : "./bq_table_schema/mer.json"
      time_partitioning : [
        {
          type  = "MONTH"
          field = "Invoicedate"
        }
      ],
      view_query_path : null
    },
    {
      name : "mrw",
      description : "Table for mrw",
      file_path : "./bq_table_schema/mrw.json"
      time_partitioning : [
        {
          type  = "MONTH"
          field = "ScanDate"
        }
      ],
      view_query_path : null
    },
  ]
}
module "table" {
  for_each = { for idx, bq in local.biq_query_tables : idx => bq }
  source   = "./modules/bigquery/table"

  project_id = var.project_id

  dataset_name      = var.bq_dataset_name
  name              = each.value.name
  description       = each.value.description
  time_partitioning = each.value.time_partitioning
  file_path         = each.value.file_path
  view_query_path   = each.value.view_query_path

  depends_on = [module.dataset]
}
