variable "environment" {
  description = "The environment of this project. e.g Staging or Production."
  type        = string
}

variable "environment_short_name" {
  description = "The short name of the environment e.g stg or prd."
  type        = string
}

variable "vm_instance" {
  description = "Specific values for this or these virtual machines."
  type = map(object({
    state    = optional(string)
    priority = optional(number)
    onboot   = optional(bool)
    vcpus    = optional(number)
    networks = optional(map(object({
      bridge   = string
      model    = string
      tag      = optional(number)
      firewall = optional(bool)
      macaddr  = optional(string)
    })))
  }))
}
