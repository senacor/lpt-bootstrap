resource "google_compute_address" "global_ip" {
  name         = "lpt-global-ip"
  address_type = "EXTERNAL"
  region       = var.gcp_region
}
resource "null_resource" "wait_for_ip" {
  depends_on = [google_compute_address.global_ip]
  provisioner "local-exec" {
    command = "sleep 30"
  }
}
resource "google_compute_router" "nat_router" {
  name    = "lpt-nat-egress-router"
  network = module.gcp_network.network_name
  region  = var.gcp_region
}
resource "google_compute_router_nat" "nat" {
  name                               = "lpt-nat-egress-router-nat"
  router                             = google_compute_router.nat_router.name
  region                             = var.gcp_region
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.global_ip.self_link]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  depends_on = [
    google_compute_address.global_ip,
    google_compute_router.nat_router,
    null_resource.wait_for_ip,
  ]
}