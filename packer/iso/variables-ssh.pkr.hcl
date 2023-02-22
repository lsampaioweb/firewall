variable "ssh_username" {
  description = "User name that Packer will use to connect to the VM through SSH."
  type        = string
  default     = "admin"
}

variable "ssh_timeout" {
  description = "The time to wait for SSH to become available."
  type        = string
  default     = "20m"
}
