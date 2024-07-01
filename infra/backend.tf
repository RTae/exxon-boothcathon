terraform {
  backend "gcs" {
    bucket  = "ai-here-tf-state-x41nt"
    prefix  = "terraform/state"
  }
}
