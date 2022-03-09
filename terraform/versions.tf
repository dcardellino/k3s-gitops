terraform {
  required_providers {
    http = {
      source  = "hashicorp/http"
      version = "~> 2.1.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.10.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
  }
}
