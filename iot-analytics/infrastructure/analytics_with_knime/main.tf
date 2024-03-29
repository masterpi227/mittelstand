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

resource "google_compute_instance" "instance-nodered" {
  name                      = "instance-nodered"
  zone                      = "us-central1-a"
  tags                      = ["nodered"]
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
    cd
    git clone https://github.com/masterpi227/mittelstand.git
    cd mittelstand/iot-basics
    chmod 777 node-red/data 
    chmod 777 node-red/data/settings.js
    chmod 777 node-red
    chmod 777 node-red/settings.js
    bash docker.sh
    bash node-red.sh
    SCRIPT

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "instance-mosquitto" {
  name                      = "instance-mosquitto"
  zone                      = "us-central1-a"
  tags                      = ["mosquitto"]
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
    cd
    git clone https://github.com/masterpi227/mittelstand.git
    cd mittelstand/iot-basics
    bash docker.sh
    bash mosquitto_noauth.sh
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
    cd mittelstand/iot-basics/sensor-basic-app
    pip3 install -r requirements.txt
    python3 main.py
    SCRIPT

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "instance-virtualpc" {
  name         = "instance-virtualpc"
  machine_type = "e2-standard-4"
  zone         = "us-central1-a"
  tags         = ["virtualpc"]

  boot_disk {
    initialize_params {
      image = "windows-server-2019-dc-v20230315"
      size  = "50"
      type  = "pd-standard"
    }
    auto_delete = true
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  metadata_startup_script = <<-EOF
    <powershell>
    $url = "https://download.knime.org/analytics-platform/win/KNIME%204.5.3%20Installer%20%2864bit%29.exe"
    $output_file = "C:\knime.exe"

    Invoke-WebRequest -Uri $url -OutFile $output_file  
    
    </powershell>
  EOF

}

resource "google_compute_firewall" "default-allow-grafana" {
  project     = var.project_id
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

resource "google_compute_firewall" "default-allow-nodered" {
  project     = var.project_id
  name        = "default-allow-nodered"
  network     = "default"
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol  = "tcp"
    ports     = ["1880"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["nodered"]
}