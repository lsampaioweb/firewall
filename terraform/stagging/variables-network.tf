variable "networks" {
  description = "Network configuration for the VM."
  type = map(object({
    model    = string
    bridge   = string
    tag      = number
    firewall = bool
  }))
}
