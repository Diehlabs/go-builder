#!/bin/sh

##########################################################
# Requires env var TF_WORKSPACE to be set.
# This is used by Terraform itself and the pipeline.
##########################################################
if [ -z "$TF_WORKSPACE" ]; then
  echo "You must set the TF_WORKSPACE environment variable for this script!"
  exit 1
fi

./terraform_download.sh
echo "------------------------------------------------------------"

terraform init &&\
echo "------------------------------------------------------------" &&\
terraform apply -auto-approve "artifacts/terraform_plan_${TF_WORKSPACE}_${BITBUCKET_BUILD_NUMBER}"
