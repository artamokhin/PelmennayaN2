
network_id           = "enpslampkiqml3fp5elu"
cluster_name         = "Momo-store-cluster"
cluster_version      = "1.23"
description          = "Kubernetes Momo cluster"
public_access        = true
create_kms           = true
enable_cilium_policy = true

kms_key = {
  name = "kube-regional-kms-key"
}

master_maintenance_windows = [
  {
    day        = "monday"
    start_time = "23:00"
    duration   = "3h"
  }
]

master_labels = {
  environment = "dev"
  owner       = "example"
  role        = "master"
  service     = "kubernetes"
}

node_groups = {
  "yc-k8s-ng-01" = {
    description = "Kubernetes nodes group for Momo-store"
    auto_scale = {
      min     = 1
      max     = 4
      initial = 1
    }
  }
  }
