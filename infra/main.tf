locals {
  project = "id-rd-ai-demo"
}

resource "random_id" "default" {
  byte_length = 8
}

resource "google_secret_manager_secret" "secret_name" {
  secret_id = "secret"

  replication {
    user_managed {
      replicas {
        location = "us-central1"
      }
    }
  }
}

resource "google_storage_bucket" "default" {
  name                        = "${random_id.default.hex}-gcf-source"
  location                    = "US"
  uniform_bucket_level_access = true
}

data "archive_file" "default" {
  type        = "zip"
  output_path = "/tmp/temperature-converter.zip"
  source_dir  = "../functions/"
}

resource "google_storage_bucket_object" "object" {
  name   = "function-source.zip"
  bucket = google_storage_bucket.default.name
  source = data.archive_file.default.output_path
}

resource "google_cloudfunctions2_function" "default" {
  name        = "temperature-converter"
  location    = "us-central1"
  description = "Function to convert temperature"

  build_config {
    runtime     = "nodejs20"
    entry_point = "convertTemp"
    source {
      storage_source {
        bucket = google_storage_bucket.default.name
        object = google_storage_bucket_object.object.name
      }
    }
  }

  service_config {
    max_instance_count = 1
    available_memory   = "256M"
    timeout_seconds    = 60

    environment_variables = {
        TEMP_CONVERT_TO = "ctof"
    }

  }
}

resource "google_cloud_run_service_iam_member" "member" {
  location = google_cloudfunctions2_function.default.location
  service  = google_cloudfunctions2_function.default.name
  role     = "roles/run.invoker"
  member   = "allAuthenticatedUsers"
}
