# go-builder
Go container for building Go projects and more - Repo managed by Terraform repo terraform-github-mgmt (azdo)


Example of using gruntwork-installer in the container:
```bash
gruntwork-install --repo https://github.com/gruntwork-io/terragrunt --tag v0.38.1 --binary-name terragrunt --no-sudo true --download-dir /tools/tmp --binary-install-d
ir /tools
```
