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
    ssh = {
      source  = "loafoe/ssh"
      version = ">= 2.1.0"
    }

  }
}
