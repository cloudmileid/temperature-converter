terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.0.0"
    }
  }

  backend "gcs" {
    bucket = "gcsb-id-rd-ai-demo-usce1-tf-backend"
    prefix = "temperature-converter/functions"
  }
}

provider "google" {
  project = "id-rd-ai-demo"
  region = "us-central1"
  zone = "us-central1-a"
}
