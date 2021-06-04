# Terraform AWS IAM module

## About:

Basic AWS IAM role and policy module that expects 2 json files (see directory: ```./lambda-policy-example/```):

1) **Assume role policy**, defines the principle service actor. In the example that is Lambda.
2) **Access policy**, defines the policies that determine which services the assumed role has access to.


## How to use:

You can copy the example files in the local module policies directory. To set up variables you can use the ```role_vars``` parameter to pass thm along to the json policy file.

```terraform
module "iam" {
  source = "github.com/rpstreef/tf-iam?ref=v1.2"

  namespace         = var.namespace
  region            = var.region
  resource_tag_name = var.resource_tag_name

  iam_module_enabled = var.iam_module_enabled

  assume_role_policy = file("${path.module}/policies/lambda-assume-role.json")
  template           = file("${path.module}/policies/lambda.json")
  role_name          = "${local.lambda_function_name}-role"
  policy_name        = "${local.lambda_function_name}-policy"

  role_vars = {
    cognito_user_pool_arn = var.cognito_user_pool_arn
  }
}
```

## Changelog

### v1.2
 - Added module on/off switch ``iam_module_enabled``
 - Added tags

### v1.1
 - Added template variables for assume role

### v1.0
 - Initial release