variable "blue_dns_name" {
  description = "DNS name of the blue environment"
  type        = string
}

variable "green_dns_name" {
  description = "DNS name of the green environment"
  type        = string
}

variable "live_environment" {
  type        = string
  description = "The currently-active environment"

  validation {
    condition     = contains(["blue", "green"], var.live_environment)
    error_message = "The live environment must be either 'blue' or 'green'"
  }
}

variable "staging_environment" {
  type        = string
  description = "The current staging environment"

  validation {
    condition     = var.staging_environment == null || contains(["blue", "green"], coalesce(var.staging_environment, "none"))
    error_message = "The staging environment must be null or either 'blue' or 'green'"
  }

}

