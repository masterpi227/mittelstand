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
    
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "instance-grafana" {
  name                      = "instance-grafana"
  zone                      = "us-central1-a"
  tags                      = ["grafana"]
  machine_type              = "n1-standard-1"
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
    bash grafana.sh
    SCRIPT

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "instance-sensorapp" {
  name                      = "instance-sensorapp"
  zone                      = "us-central1-a"
  tags                      = ["sensorapp"]
  machine_type              = "f1-micro"
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

    access_config {
      // Ephemeral public IP
    }
  }

  metadata_startup_script = <<SCRIPT
    apt update
    apt install -y git python3 python3-pip
    git clone https://github.com/masterpi227/mittelstand.git
    cd mittelstand/iot-analytics/sensor-app
    pip3 install -r requirements.txt
    python3 main.py
    SCRIPT

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_firewall" "rules" {
  project     = "workshop-iotdat"
  name        = "default-allow-grafana"
  network     = "default"
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol  = "tcp"
    ports     = ["3000"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["grafana"]
}