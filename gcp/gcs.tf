resource "google_storage_bucket" "tf_website" {
  name          = "terragot-${var.environment}"
  location      = var.location
  force_destroy = true
}

resource "google_storage_bucket_iam_binding" "allow_public_read" {
  bucket  = google_storage_bucket.tf_website.id
  members = ["allUsers"]
  role    = "roles/storage.objectViewer"
}