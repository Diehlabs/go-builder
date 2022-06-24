#!/bin/bash

tf_install() {
  if [ -z "$TF_CLI_VERSION" ]; then
    echo "You must set the TF_CLI_VERSION environment variable for this script!"
    exit 1
  else
    echo "TF_CLI_VERSION variable is set: ${TF_CLI_VERSION}"
    echo "This repository requires Terraform version ${TF_CLI_VERSION}"
  fi

  TF_DL_URL="https://releases.hashicorp.com/terraform/${TF_CLI_VERSION}/terraform_${TF_CLI_VERSION}_linux_amd64.zip"

  echo "Terraform CLI version download URL:"
  echo "$TF_DL_URL"

  MY_OUTPUT=$(curl \
    -sw '%{http_code}' \
    --retry 5 \
    --retry-delay 0 \
    --retry-max-time 10 \
    --request GET \
    -o "${DEFAULT_BIN_DIR}/terraform.zip" \
    "$TF_DL_URL")
    echo "$MY_OUTPUT" | jq -C .

  if [ "$MY_OUTPUT" -eq 200 ]; then
    unzip "${DEFAULT_BIN_DIR}/terraform.zip" -d "${DEFAULT_BIN_DIR}" &&\
      chmod +x "${DEFAULT_BIN_DIR}/terraform"
    terraform --version
  else
    echo "Got http code ${MY_OUTPUT} when downloading ${TF_DL_URL}"
    exit 1
  fi
}
