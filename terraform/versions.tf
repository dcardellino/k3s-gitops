terraform {
  required_providers {
    http = {
      source  = "hashicorp/http"
      version = "~> 2.1.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.9.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
  }
}
