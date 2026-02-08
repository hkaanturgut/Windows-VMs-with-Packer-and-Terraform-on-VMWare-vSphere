variable "vsphere_user" {
  description = "The vSphere username"
  type        = string
}

variable "vsphere_password" {
  description = "The vSphere password"
  type        = string
  sensitive   = true
}

variable "vsphere_server" {
  description = "The vSphere server address"
  type        = string
}

variable "windows_admin_password" {
  description = "Windows administrator password used for VM customization"
  type        = string
  sensitive   = true
}

variable "windows_admin_username" {
  description = "Windows administrator username used for VM customization"
  type        = string
  default     = "Administrator"
}