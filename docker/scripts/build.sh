#!/bin/bash
# This file is a mix of these two files : 
# - https://github.com/Accenture/serverless-ephemeral/blob/master/src/lib/packager/tensorflow/scripts/build.sh
# - https://github.com/ryfeus/lambda-packs/blob/master/Tensorflow/buildPack_py3.sh

# Start virtual environment and install Pillow and request
SOURCE=https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.7.0-cp36-cp36m-linux_x86_64.whl
. /venv/bin/activate && pip install git+https://github.com/inspirehep/magpie.git@v2.0 && pip install --upgrade --ignore-installed --no-cache-dir ${SOURCE} && deactivate

# Add __init__.py because of this issue https://github.com/tensorflow/tensorflow/issues/3086
touch /venv/lib64/python3.6/site-packages/google/__init__.py

cd /venv/lib64/python3.6/site-packages

# cleaning unused libs recursively
dirs=("/venv/lib64/python3.6/site-packages/")
for dir in "${dirs[@]}"
do
  cd ${dir}
  rm -rf easy_install* pip* pip-* setup_tools* setuptools* wheel* wheel-* examples* tests* external* __MACOSX* unsupported* thirdparty* docker* # Remove unnecessary libraries to save space
  find . -name \*.pyc -delete
  find -name "*.so" | xargs strip
  find -name "*.so.*" | xargs strip
  find -name "*.md*" | xargs strip
  find . -type d -name "tests" -exec rm -rf {} +
  find . -type d -name "test" -exec rm -rf {} +
  find . -type d -name "docs" -exec rm -rf {} +
  find . -type d -name "docs_api" -exec rm -rf {} +
  find . -type d -name "licenses" -exec rm -rf {} +
  find . -type d -name "ci" -exec rm -rf {} +
  find . -type d -name "windows" -exec rm -rf {} +
  find . -type d -name "benchamrks" -exec rm -rf {} +
  find . -type d -name "build__tools" -exec rm -rf {} +
  find . -type d -name "datasets" -exec rm -rf {} +
  find . -type d -name "doc" -exec rm -rf {} +
  find . -type d -name "example" -exec rm -rf {} +
  find . -type d -name "examples" -exec rm -rf {} +
  
done

# Zip libraries
output=/tmp/libs
mkdir -p ${output}
zip -r9q ${output}/text-classification.zip *