# go-builder
Go container for building Go projects and more - Repo managed by Terraform repo terraform-github-mgmt (azdo)

Example usage:
```bash
# interactive session
docker run --rm -it \
  -e TF_CLI_VERSION=1.2.3 \
  cultclassik/go-builder:latest

# run a script in the container
docker run --rm \
  -e TF_CLI_VERSION=1.2.3 \
  cultclassik/go-builder:latest \
  common.sh
```

Example of using gruntwork-installer in the container:
```bash
gruntwork-install \
  --repo https://github.com/gruntwork-io/terragrunt \
  --tag v0.38.1 \
  --binary-name terragrunt \
  --no-sudo true \
  --download-dir /tools/tmp \
  --binary-install-dir /tools

gruntwork-install \
  --repo https://github.com/gruntwork-io/terratest \
  --tag v0.40.17 \
  --binary-name terratest_log_parser \
  --no-sudo true \
  --download-dir /tools/tmp \
  --binary-install-dir /tools

```
