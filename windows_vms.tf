resource "vsphere_virtual_machine" "Win2022-Template-Base-Terraform" {
  name             = "Win2022-Terraform"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = 2
  memory   = 4096
  guest_id = data.vsphere_virtual_machine.Win2022-Template.guest_id

  firmware = "bios"
  efi_secure_boot_enabled = false
  wait_for_guest_net_timeout = 20
  wait_for_guest_ip_timeout  = 20

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.Win2022-Template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.Win2022-Template.disks[0].size
    thin_provisioned = true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.Win2022-Template.id
  }
}