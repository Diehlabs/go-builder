#!/bin/bash

source "${DEFAULT_BIN_DIR}/common.sh"

##########################################################
# Requires env var TF_WORKSPACE to be set.
# This is used by Terraform itself and the pipeline.
##########################################################
if [ -z "$TF_WORKSPACE" ]; then
  echo "You must set the TF_WORKSPACE environment variable for this script!"
  exit 1
fi

mkdir ./artifacts

tf_install
echo "------------------------------------------------------------"

terraform init &&\
echo "------------------------------------------------------------" &&\
terraform validate &&\
echo "------------------------------------------------------------" &&\
terraform plan -out="artifacts/terraform_plan_${TF_WORKSPACE}_${BITBUCKET_BUILD_NUMBER}" -var-file="./variables/${TF_WORKSPACE}.tfvars"

# Will use the exit code to determine if an apply stage should be triggered

# -detailed-exitcode  Return detailed exit codes when the command exits. This
#                     will change the meaning of exit codes to:
#                     0 - Succeeded, diff is empty (no changes)
#                     1 - Errored
#                     2 - Succeeded, there is a diff
