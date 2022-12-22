variable "vm_instance" {
  description = "Specific values for this or these virtual machines."
  type = map(object({
    state    = optional(string)
    priority = optional(number)
    onboot   = optional(bool)
    vcpus    = optional(number)
    networks = optional(map(object({
      model    = string
      bridge   = string
      tag      = optional(number)
      firewall = optional(bool)
      macaddr  = optional(string)
    })))
  }))
}
