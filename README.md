# opentofu-module-autoglue-metadata
<!-- BEGIN_TF_DOCS -->


```hcl
module "cluster_metadata" {
  source = "git::https://github.com/GlueOps/opentofu-module-autoglue-metadata.git?ref=vX.Y.Z" # replace with the desired tag (e.g., v0.0.2)
  cluster_id       = autoglue_cluster.cluster.id
  cluster_metadata = var.cluster_metadata
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
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | The ID of the autoglue cluster | `string` | n/a | yes |
| <a name="input_cluster_metadata"></a> [cluster\_metadata](#input\_cluster\_metadata) | Key-value pairs to store as cluster metadata | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->