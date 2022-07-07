resource "google_container_cluster" "gke-cluster" {
  name               = "${var.app_name}-cluster"
  location           = var.gcp_zone_1
  initial_node_count = 3

  node_config {
    preemptible  = true
    machine_type = "e2-small"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}