resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  description             = "VPC for the cluster"
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  description   = "Subnet of the VPC"
  ip_cidr_range = var.subnet_cidr_range
  region        = var.region
  network       = google_compute_network.vpc.id

  secondary_ip_range {
    range_name    = "gke-pod-range"
    ip_cidr_range = var.subnet_pod_cidr_range
  }

  secondary_ip_range {
    range_name    = "gke-service-range"
    ip_cidr_range = var.subnet_service_cidr_range
  }
}

resource "google_compute_address" "istio_ingress_ip" {
  name         = "istio-ingress-ip"
  region       = var.region
  address_type = "EXTERNAL"
  project      = var.project_id
}
