terraform {
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "terraform-momo-store"
    region     = "ru-central1"
    key        = "Momo-store.tfstate"
    access_key = "***REMOVED***"
    secret_key = "***REMOVED***"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}