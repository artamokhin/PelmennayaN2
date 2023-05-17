data "yandex_client_config" "client" {}

module "kube" {
  source = "../"

  network_id      = "enpslampkiqml3fp5elu"
  cluster_name    = "momo-store-cluster"
  cluster_version = "1.23"
  description     = "Kubernetes momo cluster"

  master_locations = [
    {
      zone      = "ru-central1-a"
      subnet_id = "e9bq88jr2lh7ht65k2gl"
    }
  ]

  node_groups = {
    "yc-k8s-ng" = {
      description = "Kubernetes nodes group for Momo-store"
      auto_scale  = {
        min     = 1
        max     = 3
        initial = 1
      }
      node_cores = 2
      node_memory     = 4
      core_fraction   = 20
      disk_type       = "network-hdd"
      disk_size       = 40
    }
  }
}
