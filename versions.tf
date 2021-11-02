terraform {
  required_providers {
    cloudfoundry = {
      source = "cloudfoundry-community/cloudfoundry"
    }
    random = {
      source = "random"
    }
    hsdp = {
      source  = "philips-software/hsdp"
      version = ">= 0.26.3"
    }
  }
}
