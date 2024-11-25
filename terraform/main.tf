provider "libvirt" {
  uri = "qemu:///system"
}

# Define the network
resource "libvirt_network" "kvm_network" {
  name   = "lab-network"
  domain = "lab.local"
  mode   = "nat"
  addresses = ["192.168.122.0/24"]
}

# Base image
variable "base_image" {
  default = "/path/to/output-rocky-linux/rocky-linux-kvm-image.qcow2"
}

# Create the workstation
resource "libvirt_volume" "workstation_disk" {
  name   = "workstation.qcow2"
  pool   = "default"
  source = var.base_image
  format = "qcow2"
}

resource "libvirt_domain" "workstation" {
  name   = "workstation"
  memory = 1024
  vcpu   = 1
  network_interface {
    network_id   = libvirt_network.kvm_network.id
    addresses    = ["192.168.122.100"]
  }
  disk {
    volume_id = libvirt_volume.workstation_disk.id
  }
  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }
}

# Create servera
resource "libvirt_volume" "servera_disk" {
  name   = "servera.qcow2"
  pool   = "default"
  source = var.base_image
  format = "qcow2"
}

resource "libvirt_domain" "servera" {
  name   = "servera"
  memory = 1024
  vcpu   = 1
  network_interface {
    network_id   = libvirt_network.kvm_network.id
    addresses    = ["192.168.122.101"]
  }
  disk {
    volume_id = libvirt_volume.servera_disk.id
  }
  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }
}

# Create serverb
resource "libvirt_volume" "serverb_disk" {
  name   = "serverb.qcow2"
  pool   = "default"
  source = var.base_image
  format = "qcow2"
}

resource "libvirt_domain" "serverb" {
  name   = "serverb"
  memory = 1024
  vcpu   = 1
  network_interface {
    network_id   = libvirt_network.kvm_network.id
    addresses    = ["192.168.122.102"]
  }
  disk {
    volume_id = libvirt_volume.serverb_disk.id
  }
  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }
}