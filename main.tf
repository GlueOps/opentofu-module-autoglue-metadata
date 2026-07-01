resource "autoglue_cluster_metadata" "this" {
  for_each = var.cluster_metadata

  cluster_id = var.cluster_id
  key        = each.key
  value      = each.value
}
