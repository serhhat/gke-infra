resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.zone

  deletion_protection      = false
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.id
  subnetwork = google_compute_subnetwork.subnet.id

  ip_allocation_policy {
    cluster_secondary_range_name  = "gke-pod-range"
    services_secondary_range_name = "gke-service-range"
  }

  logging_service    = "none"
  monitoring_service = "none"

  network_policy {
    enabled  = true
    provider = "CALICO"
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "03:30"
    }
  }
}

# Main Pool
resource "google_container_node_pool" "main_pool" {
  name     = "main-pool"
  location = var.zone
  cluster  = google_container_cluster.primary.name

  depends_on = [google_container_cluster.primary]

  node_count = var.main_pool_node_count

  node_config {
    machine_type    = var.main_pool_machine_type
    disk_size_gb    = 20
    service_account = google_service_account.gke_sa.email

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    labels = {
      pool = "main-pool"
    }

    tags = ["gke-node", "main-pool"]
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}

# Application Pool
resource "google_container_node_pool" "application_pool" {
  name     = "application-pool"
  location = var.zone
  cluster  = google_container_cluster.primary.name
 
  initial_node_count = var.app_pool_min_node_count

  node_config {
    machine_type    = var.app_pool_machine_type
    disk_size_gb    = 20
    service_account = google_service_account.gke_sa.email

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    labels = {
      pool = "application-pool"
    }

    tags = ["gke-node", "application-pool"]
  }

  autoscaling {
    min_node_count = var.app_pool_min_node_count
    max_node_count = var.app_pool_max_node_count
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}

resource "google_service_account" "gke_sa" {
  account_id   = "gke-service-account-case"
  display_name = "GKE SA"
  description  = "SA for GKE Nodes"
}

resource "google_project_iam_member" "gke_sa_artifact_registry_reader" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.gke_sa.email}"
}
