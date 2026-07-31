# opentofu-module-autoglue-metadata
<!-- BEGIN_TF_DOCS -->
```hcl
module "cluster_metadata" {
  source     = "git::https://github.com/GlueOps/opentofu-module-autoglue-metadata.git?ref=v0.0.3" # x-release-please-version
  cluster_id = autoglue_cluster.cluster.id

  cluster_metadata = {
    calico_network_calico_cidr = "10.244.0.0/16"
    network_service_cidr       = "10.96.0.0/12"
    cloud                      = "proxmox" # one of: aws, proxmox, hetzner

    # Cloud-specific overrides. When cloud = "proxmox",
    # calico_node_address_autodetection_v4 is required.
    cloud_vars = {
      calico_node_address_autodetection_v4 = "cidr=10.0.0.0/24"
    }
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_autoglue"></a> [autoglue](#requirement\_autoglue) | 0.10.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_autoglue"></a> [autoglue](#provider\_autoglue) | 0.10.12 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| autoglue_cluster_metadata.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | The ID of the autoglue cluster that this metadata is attached to. | `string` | n/a | yes |
| <a name="input_cluster_metadata"></a> [cluster\_metadata](#input\_cluster\_metadata) | Structured cluster metadata. All fields are required unless noted:<br/>  - calico\_network\_calico\_cidr: CIDR block for the Calico pod network (e.g. "10.244.0.0/16").<br/>  - network\_service\_cidr:       CIDR block for Kubernetes services (e.g. "10.96.0.0/12").<br/>  - cloud:                      Target cloud provider. One of: "aws", "proxmox", "hetzner".<br/>  - cloud\_vars:                 Optional map of cloud-specific overrides. When cloud is "proxmox",<br/>                                "calico\_node\_address\_autodetection\_v4" is required. | <pre>object({<br/>    calico_network_calico_cidr = string<br/>    network_service_cidr       = string<br/>    cloud                      = string<br/>    cloud_vars                 = optional(map(string), {}) # Holds the cloud-specific overrides<br/>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
