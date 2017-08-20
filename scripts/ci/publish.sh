#!/usr/bin/env bash

set -e

if [ -z $PUBLISH_STORAGE_SAS ]; then
    echo 'Missing publish storage account credential. Skip publishing.'
    exit 0
fi

echo 'Installing public Azure CLI for uploading operation.'
pip install -qqq azure-cli

echo 'Uploading ...'
az storage blob upload-batch -s $HOME/share \
                             -d $PUBLISH_CONTAINER \
                             --pattern $TRAVIS_REPO_SLUG/$TRAVIS_BUILD_NUMBER/* \
                             --account-name $PUBLISH_STORAGE_ACCT \
                             --sas-token $PUBLISH_STORAGE_SAS \
                             -otable