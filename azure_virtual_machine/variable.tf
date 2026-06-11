variable "virtual_machine" {
  type = map(object({
    name              = string
    resource_group_name = string
    location          = string
    vm_size           = string
    os_type           = string # "Windows" or "Linux"
    image_publisher   = string
    image_offer       = string
    image_sku         = string
    image_version     = string
    admin_username    = string
    admin_password    = string
    subnet_id         = string
    public_ip_needed  = bool
  }))
  default = {}
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to SSH public key for Linux VMs"
  default     = "~/.ssh/id_ed25519.pub"
}