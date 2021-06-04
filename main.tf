locals {
  resource_name_prefix = "${var.environment}-${var.resource_tag_name}"

  tags = {
    Environment = var.environment
    Name        = var.resource_tag_name
  }
}

# -----------------------------------------------------------------------------
# Data: IAM
# -----------------------------------------------------------------------------

data "template_file" "_" {
  count = var.iam_module_enabled ? 1 : 0

  template = var.template
  vars     = var.role_vars
}

data "template_file" "assumerole" {
  count = var.iam_module_enabled ? 1 : 0

  template = var.assume_role_policy
  vars     = var.role_vars
}

# -----------------------------------------------------------------------------
# Resources: IAM Lambda Roles and Policies
# -----------------------------------------------------------------------------

resource "aws_iam_role" "_" {
  count = var.iam_module_enabled ? 1 : 0

  name = "${local.resource_name_prefix}-${var.role_name}"

  assume_role_policy = data.template_file.assumerole.rendered

  tags = local.tags
}

resource "aws_iam_policy" "_" {
  count = var.iam_module_enabled ? 1 : 0

  name = "${local.resource_name_prefix}-${var.policy_name}"

  policy = data.template_file._.rendered

  tags = local.tags
}

resource "aws_iam_policy_attachment" "_" {
  count = var.iam_module_enabled ? 1 : 0

  name = "${local.resource_name_prefix}-${var.policy_attachment_name}"

  policy_arn = one(aws_iam_policy._.*.arn)
  roles      = [one(aws_iam_role._.*.name)]
}
