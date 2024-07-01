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