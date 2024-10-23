data "google_dns_managed_zone" "lpt" {
  name = "lpt"
}

resource "google_dns_record_set" "creditapplication-service" {
  name         = "creditapplication.api.lpt.senacor.com."
  managed_zone = data.google_dns_managed_zone.lpt.name
  type         = "A"
  ttl          = 300
  rrdatas      = [google_compute_global_address.creditapplication_service_ingress_ip.address]
}

resource "google_compute_global_address" "creditapplication_service_ingress_ip" {
  name = "creditapplication-service-public-ip"
}
