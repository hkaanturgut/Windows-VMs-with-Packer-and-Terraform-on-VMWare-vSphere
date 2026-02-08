packer {
  required_plugins {
    vsphere = {
      version = "~> 1"
      source  = "github.com/hashicorp/vsphere"
    }
  }
}

variable "vsphere-server" {}
variable "vsphere-user" {}
variable "vsphere-password" {}
variable "vsphere-datacenter" {}
variable "vsphere-cluster" {}
variable "vsphere-datastore" {}
variable "vsphere-folder" {}
variable "winadmin-password" {}
variable "vm-name" {}
variable "vm-cpu-num" {}
variable "vm-mem-size" {}
variable "os-disk-size" {}
variable "disk-thin-provision" {}
variable "vsphere-network" {}
variable "os_iso_path" {}

source "vsphere-iso" "windows2022" {
  vcenter_server        = var.vsphere-server
  username              = var.vsphere-user
  password              = var.vsphere-password
  insecure_connection   = true
  datacenter            = var.vsphere-datacenter
  cluster               = var.vsphere-cluster
  datastore             = var.vsphere-datastore
  folder                = var.vsphere-folder
  communicator          = "winrm"
  winrm_username        = "Administrator"
  winrm_password        = var.winadmin-password
  winrm_timeout         = "1h30m"
  convert_to_template   = true
  vm_name               = var.vm-name
  guest_os_type         = "windows9Server64Guest"
  CPUs                  = var.vm-cpu-num
  RAM                   = var.vm-mem-size
  RAM_reserve_all       = true
  firmware              = "bios"
  storage {
    disk_size           = var.os-disk-size
    disk_thin_provisioned = var.disk-thin-provision
  }
  disk_controller_type  = ["lsilogic-sas"]
  network_adapters {
    network             = var.vsphere-network
    network_card        = "vmxnet3"
  }
  shutdown_command      = "shutdown /s /t 5"
  iso_paths             = [var.os_iso_path, "[] /vmimages/tools-isoimages/windows.iso"]
  floppy_files          = [
    "packer-vsphere/windows/autounattend.xml",
    "packer-vsphere/windows/scripts/disable-network-discovery.cmd",
    "packer-vsphere/windows/scripts/disable-server-manager.ps1",
    "packer-vsphere/windows/scripts/enable-rdp.cmd",
    "packer-vsphere/windows/scripts/enable-winrm.ps1",
    "packer-vsphere/windows/scripts/install-vm-tools.cmd",
    "packer-vsphere/windows/scripts/set-temp.ps1"
  ]
}

build {
  sources = ["source.vsphere-iso.windows2022"]
  provisioner "windows-shell" {
    inline = ["ipconfig /all"]
  }
}
