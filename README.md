# Github Action OIDC Role

## Information

Using terraform, AWS resources can be created such as IAM roles and Github resources such as repository pipelines, aka Github Actions. IdP-authenticated pipelines will assume the IAM role with the permissions from the policy document. Pipelines will then have workflows configured with short-lived access token directly from the cloud provider, allowing fine grained of only that pipeline either from main, any pull request, or a specific branch. 

- [Github Actions OpenID Connect with AWS](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)
- [Creating OpenID Roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc.html)
- [Terraform Github Provider](https://registry.terraform.io/providers/integrations/github/latest/docs)


## Environment

This project uses...
- [terraform](https://learn.hashicorp.com/tutorials/terraform/infrastructure-as-code?in=terraform/aws-get-started) (v1.4.6) For IaC.

### Usage:

Create a github token with [repo] access, copy the text to a `token.txt` file and save in the `tf/` directory.
You can then run Terraform init from the `tf/` directory. Remote state hasn't been created, so comment out all resources except for `bootstrap.tf`.
Terraform apply to create the S3 Bucket and DynamoDB table for the remote backend, after uncomment the `backend.tf` and terraform init to reinitialize terraform. Uncomment the previous resources then terraform apply, creating the oidc provider, iam role, and github secrets.

```
terraform init
GITHUB_OWNER=<org-name> GITHUB_TOKEN="$(cat token.txt)" terraform plan
GITHUB_OWNER=<org-name> GITHUB_TOKEN="$(cat token.txt)" terraform apply
```
