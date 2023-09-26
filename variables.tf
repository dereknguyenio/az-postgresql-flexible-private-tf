variable "name_prefix" {
  default     = "postgresqlfs"
  description = "Prefix of the resource name."
}

variable "location" {
  default     = "eastus"
  description = "Location of the resource."
}

variable "environment" {
  description = "The environment where the infrastructure is deployed"
  type        = string
  default     = "dev"
}

