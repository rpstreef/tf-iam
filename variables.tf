# -----------------------------------------------------------------------------
# Variables: General
# -----------------------------------------------------------------------------

variable "environment" {
  description = "AWS resource environment/prefix"
}

variable "region" {
  description = "AWS region"
}

variable "resource_tag_name" {
  description = "Resource tag name for cost tracking"
}

variable "iam_module_enabled" {
  type        = bool
  description = "(Optional) Whether to create resources within the module or not. Default is true."
  default     = true
}

# -----------------------------------------------------------------------------
# Variables: IAM
# -----------------------------------------------------------------------------

variable "template" {
  description = "JSON template describing the permissions"
}

variable "role_name" {
  description = "Name of the role"
}

variable "policy_name" {
  description = "Name of the policy"
}

variable "policy_attachment_name" {
  description = "Name of the policy attachment document"
  default = "attachment"
}

variable "role_vars" {
  description = "Variables within the JSON template to be included"
  type        = map(string)
}

variable "assume_role_policy" {
  description = "Assume role policy JSON"
}