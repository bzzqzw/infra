# Instruct terraform to download the provider on `terraform init`
terraform {
  required_providers {
    xenorchestra = {
      source  = "terra-farm/xenorchestra"
      version = "0.23.3"
    }
  }
}

variable "xenorchestra_url" {
  type = string
}

variable "xenorchestra_username" {
  type = string
}

variable "xenorchestra_password" {
  type = string
}

# Configure the XenServer Provider
provider "xenorchestra" {
  # Must be ws or wss
  url      = var.xenorchestra_url      # Or set XOA_URL environment variable
  username = var.xenorchestra_username # Or set XOA_USER environment variable
  password = var.xenorchestra_password # Or set XOA_PASSWORD environment variable

  # This is false by default and
  # will disable ssl verification if true.
  # This is useful if your deployment uses
  # a self signed certificate but should be
  # used sparingly!
  #insecure = true # Or set XOA_INSECURE environment variable to any value
}
