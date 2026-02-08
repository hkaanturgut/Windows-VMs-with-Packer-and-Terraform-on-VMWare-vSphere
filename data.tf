

data "vsphere_datacenter" "datacenter" {
  name = "homelab-dc"
}

data "vsphere_datastore" "datastore" {
  name          = "datastore1"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = "homelab-cluster"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "Win2022-Template" {
  name          = "Win2022-Template"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}


