variable "cluster_id" {
  type        = string
  description = "The ID of the autoglue cluster"
}

variable "cluster_metadata" {
  type        = map(string)
  description = "Key-value pairs to store as cluster metadata"
  default     = {}
}
