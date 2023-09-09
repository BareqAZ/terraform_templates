variable "name" {
  default     = "Terraform-test"
  type        = string
  description = "The \"Name\" tag used for the resources. (Project name)"
}

variable "owner" {
  default     = "terraform@example.com"
  type        = string
  description = "The \"owner\" tag (Your Email)."
}

variable "local_os" {
  default     = "linux"
  type        = string
  description = "Your operating system. (windows/linux)"
}
