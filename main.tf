locals {
  # Flatten the structured cluster_metadata object into a single map(string)
  # so each field (plus any cloud-specific overrides) becomes an individual
  # autoglue_cluster_metadata entry.
  cluster_metadata = merge(
    {
      calico_network_calico_cidr = var.cluster_metadata.calico_network_calico_cidr
      network_service_cidr       = var.cluster_metadata.network_service_cidr
      cloud                      = var.cluster_metadata.cloud
    },
    var.cluster_metadata.cloud_vars,
  )
}

resource "autoglue_cluster_metadata" "this" {
  for_each = local.cluster_metadata

  cluster_id = var.cluster_id
  key        = each.key
  value      = each.value
}
