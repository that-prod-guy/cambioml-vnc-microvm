output "cluster_name" {
  value = google_container_cluster.primary.name
}
output "region" {
  value = var.region
}
