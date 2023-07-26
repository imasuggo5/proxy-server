terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  project = "imasuggo5"
  region  = "us-west1"
  zone    = "us-west1-b"
}

resource "tls_private_key" "proxy_server" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "proxy_server_pem" {
  content         = tls_private_key.proxy_server.private_key_pem
  filename        = "${path.module}/.ssh/proxy_server.pem"
  file_permission = "0600"
}

resource "google_compute_address" "proxy_server" {
  name = "proxy-server"
}

resource "google_compute_firewall" "allow-http" {
  name    = "allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

resource "google_compute_firewall" "allow-https" {
  name    = "allow-https"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["https-server"]
}

resource "google_compute_firewall" "allow-frp" {
  name    = "allow-frp"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["7000"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["frp-server"]
}

resource "google_compute_instance" "proxy_server" {
  name         = "proxy-server"
  machine_type = "e2-micro"

  tags = ["http-server", "https-server", "frp-server"]

  boot_disk {
    initialize_params {
      image = "centos-stream-9-v20230711"
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = local.remote_host
    }
  }

  metadata = {
    ssh-keys = "${local.remote_user}:${tls_private_key.proxy_server.public_key_openssh}"
  }

}

locals {
  remote_host     = google_compute_address.proxy_server.address
  remote_user     = "ansible"
  remote_key_file = local_file.proxy_server_pem.filename
}

resource "null_resource" "ansible" {

  triggers = {
    always = timestamp()
  }

  depends_on = [
    google_compute_instance.proxy_server
  ]

  provisioner "local-exec" {
    command = <<EOT
    ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook \
      -i ${local.remote_host}, \
      -u ${local.remote_user} \
      --key-file ${local.remote_key_file} \
      site.yml
    EOT
  }

}
