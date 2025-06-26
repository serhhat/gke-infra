# Project Variables
variable "project_id" {
  default = "playground-459722"
}

variable "region" {
  default = "europe-west1"
}

variable "zone" {
  default = "europe-west1-b"
}

# VPC Variables
variable "vpc_name" {
  default = "gke-vpc"
}

variable "subnet_name" {
  default = "gke-subnet"
}

variable "subnet_cidr_range" {
  default = "10.0.0.0/16"
}

variable "subnet_pod_cidr_range" {
  default = "10.1.0.0/16"
}

variable "subnet_service_cidr_range" {
  default = "10.2.0.0/16"
}


# GKE Variables
variable "cluster_name" {
  default = "gke-cluster"
}

variable "app_pool_min_node_count" {
  default = 1
}

variable "app_pool_max_node_count" {
  default = 3
}

variable "app_pool_machine_type" {
  default = "n2d-standard-2"
}

# Main Pool Variables
variable "main_pool_node_count" {
  default = 1
}

variable "main_pool_machine_type" {
  default = "n2d-standard-2"
}