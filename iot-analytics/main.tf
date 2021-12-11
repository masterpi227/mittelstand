provider "google" {
  region = "us-central1"
}


resource "google_compute_instance" "instance-influxdb" {
  name                      = "instance-influxdb"
  zone                      = "us-central1-a"
  tags                      = ["influxdb"]
  machine_type              = "n1-standard-2"
  allow_stopping_for_update = true

  boot_disk {
    auto_delete = "true"

    initialize_params {
      image = "debian-cloud/debian-10"
      size  = "10"
    }
  }

  network_interface {
    network = "default"
    tags    = ["influxdb"]

    access_config {
      // Ephemeral public IP
    }
  }

  metadata_startup_script = <<SCRIPT
    apt update
    apt install -y git
    git clone https://github.com/masterpi227/mittelstand.git
    cd mittelstand/iot-basics
    bash docker.sh
    bash influxdb.sh
    SCRIPT

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}
