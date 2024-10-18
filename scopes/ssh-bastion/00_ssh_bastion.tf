data "google_project" "project" {
  project_id = var.project_id
}

data "google_compute_zones" "available" {
  project = data.google_project.project.project_id
}

data "google_compute_network" "gke_vpc" {
  name = var.vpc_name
  project = data.google_project.project.project_id
}

data "google_compute_subnetwork" "master_subnet" {
  name = var.subnet_name
  project = data.google_project.project.project_id
}

resource "google_compute_instance" "bastion_host" {
  name         = "bastion-host"
  machine_type = "n1-standard-1"
  zone         = data.google_compute_zones.available.names[0]

  boot_disk {
    initialize_params {
      image = "debian-11"
    }
  }

  network_interface {
    network    = data.google_compute_network.gke_vpc.name #google_compute_network.vpc_network.name
    subnetwork = data.google_compute_subnetwork.master_subnet.name # google_compute_subnetwork.vpc_subnet.name
    access_config {} # Allows external SSH access to the bastion host.
  }

  metadata = {
    user-data = file("${path.module}/cloud-config.yaml")
    ssh-keys = "lpt:${var.ssh_pub}"
  }

  tags = ["bastion"]
}

resource "google_compute_firewall" "allow_bastion_ssh_from_public" {
  name    = "allow-bastion-ssh"
  network = data.google_compute_network.gke_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["bastion"]
}

resource "google_compute_firewall" "allow_bastion_to_gke" {
  name    = "allow-bastion-to-gke"
  network = data.google_compute_network.gke_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["443"] # Port for GKE control plane
  }

  source_tags = ["bastion"]
  destination_ranges = [data.google_compute_subnetwork.master_subnet.ip_cidr_range] # GKE master CIDR
}