#!/usr/bin/env bash

set -e

. $(cd $(dirname $0); pwd)/artifacts.sh

pip install pylint flake8
pip install azure-cli-fulltest -f $share_folder/build

proc_number=`python -c 'import multiprocessing; print(multiprocessing.cpu_count())'`

echo "Run pylint with $proc_number proc."
pylint azure.cli --rcfile=./pylintrc -j $proc_number

echo "Run flake8."
flake8 --statistics --exclude=azure_bdist_wheel.py --append-config=./.flake8 ./src

pip install -e ./tools
echo "Scan license"
azt verify license

echo "Documentation Map"
azt verify document-map

echo "Command lint"
python -m automation.commandlint.run 

echo "Verify readme history"
python -m automation.tests.verify_readme_history

echo "Verify default modules"
azt verify default-modules $share_folder/build
