provider "google" {
  project = var.project
  region = var.region
  zone = var.zone
}

resource "random_id" "instance_id" {
  byte_length = 6
}

resource "google_compute_instance" "default" {
  name = "flask-vm-${random_id.instance_id.hex}"
  machine_type = var.machine_type

  boot_disk{
      initialize_params {
          image = var.image
      }
  }

  # scratch_disk {
  #   interface = "SCSI"
  # }

  metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python-pip rsync; pip install flask"

  network_interface {
      network = "default"
      access_config{
          // Include this section to give the VM an external ip address
      }
  }

}