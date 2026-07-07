variable "cluster_id" {
  type        = string
  description = "The ID of the autoglue cluster that this metadata is attached to."

  validation {
    condition     = length(trimspace(var.cluster_id)) > 0
    error_message = "The 'cluster_id' must not be empty."
  }
}

variable "cluster_metadata" {
  type = object({
    calico_network_calico_cidr = string
    network_service_cidr       = string
    cloud                      = string
    cloud_vars                 = optional(map(string), {}) # Holds the cloud-specific overrides
  })
  description = <<-EOT
    Structured cluster metadata. All fields are required unless noted:
      - calico_network_calico_cidr: CIDR block for the Calico pod network (e.g. "10.244.0.0/16").
      - network_service_cidr:       CIDR block for Kubernetes services (e.g. "10.96.0.0/12").
      - cloud:                      Target cloud provider. One of: "aws", "proxmox", "hetzner".
      - cloud_vars:                 Optional map of cloud-specific overrides. When cloud is "proxmox",
                                    "calico_node_address_autodetection_v4" is required.
  EOT

  validation {
    # Ensure the cloud is an allowed provider.
    condition     = contains(["aws", "proxmox", "hetzner"], var.cluster_metadata.cloud)
    error_message = "The 'cloud' field must be one of: 'aws', 'proxmox', or 'hetzner'."
  }

  validation {
    # Ensure the Calico pod network CIDR is a valid IPv4 CIDR.
    condition     = can(cidrhost(var.cluster_metadata.calico_network_calico_cidr, 0))
    error_message = "The 'calico_network_calico_cidr' field must be a valid IPv4 CIDR (e.g. '10.244.0.0/16')."
  }

  validation {
    # Ensure the service network CIDR is a valid IPv4 CIDR.
    condition     = can(cidrhost(var.cluster_metadata.network_service_cidr, 0))
    error_message = "The 'network_service_cidr' field must be a valid IPv4 CIDR (e.g. '10.96.0.0/12')."
  }

  validation {
    # If cloud is proxmox, 'calico_node_address_autodetection_v4' must be provided in cloud_vars.
    condition = (
      var.cluster_metadata.cloud != "proxmox" ||
      contains(keys(var.cluster_metadata.cloud_vars), "calico_node_address_autodetection_v4")
    )
    error_message = "When 'cloud' is set to 'proxmox', you must provide 'calico_node_address_autodetection_v4' inside 'cloud_vars'."
  }
}
