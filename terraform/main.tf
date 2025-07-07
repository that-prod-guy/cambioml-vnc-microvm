resource "google_container_cluster" "primary" {
  name     = "cambioml-cluster"
  location = var.region
  initial_node_count = 1

  node_config {
    machine_type = "e2-standard-2"
    disk_size_gb = 50  
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
