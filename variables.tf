variable "cluster_id" {
  type        = string
  description = "The ID of the autoglue cluster"
}

variable "cluster_metadata" {
  type = object({
    calico_network_calico_cidr = string
    network_service_cidr       = string
    cloud                      = string
    cloud_vars                 = optional(map(string), {}) # Holds the cloud-specific overrides
  })
  description = "Structured cluster metadata: network CIDRs, the target cloud provider, and any cloud-specific overrides."

  validation {
    # Rule 1: Ensure the cloud is an allowed provider
    condition     = contains(["aws", "proxmox", "hetzner"], var.cluster_metadata.cloud)
    error_message = "The 'cloud' field must be one of: 'aws', 'proxmox', or 'hetzner'."
  }

  validation {
    # Rule 2: If cloud is PROXMOX, ensure 'calico_node_address_autodetection_v4' is provided in cloud_vars
    condition = (
      var.cluster_metadata.cloud != "proxmox" ||
      contains(keys(var.cluster_metadata.cloud_vars), "calico_node_address_autodetection_v4")
    )
    error_message = "When 'cloud' is set to 'proxmox', you must provide 'calico_node_address_autodetection_v4' inside 'cloud_vars'."
  }
}
