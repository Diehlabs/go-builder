#!/bin/bash

source "${DEFAULT_BIN_DIR}/functions.sh"

export TF_INPUT=0
VAR_FILES_INPUT=$1

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


# append var files passed as $1 to the base command
if [ -n "$VAR_FILES_INPUT" ]; then
  IFS=',' read -r -a array <<< "$VAR_FILES_INPUT"
  for file in "${array[@]}"
  do
    TF_CMD_ARGS+='-var-file='
    TF_CMD_ARGS+="$file "
  done
fi

#execute the terraform command
TF_CMD="terraform plan -out=artifacts/terraform_plan_${TF_WORKSPACE}_${BITBUCKET_BUILD_NUMBER} ${TF_CMD_ARGS}"
echo "Running command:"
echo "$TF_CMD"
bash -c "$TF_CMD"


# Will use the exit code to determine if an apply stage should be triggered

# -detailed-exitcode  Return detailed exit codes when the command exits. This
#                     will change the meaning of exit codes to:
#                     0 - Succeeded, diff is empty (no changes)
#                     1 - Errored
#                     2 - Succeeded, there is a diff
