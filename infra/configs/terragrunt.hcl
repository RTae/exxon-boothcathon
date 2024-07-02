terraform {
  source = "..//"
}

locals {
  project_id = "ai-here"
  location = "asia-southeast1"
}

remote_state {
  backend = "gcs"

  config = {
    project  = local.project_id
    location = local.location
    bucket   = "ai-here-tf-state-x41nt"
    prefix   = "terraform/state"
  }
}

inputs = {
  project_id      = local.project_id
  location        = local.location
  access_members  = [
    {
      role : "OWNER"
      email : "kasidit.suwannagarn@gmail.com"
    },
    {
      role : "OWNER"
      email : "natthanan.bhu@gmail.com"
    },
  ]
}
