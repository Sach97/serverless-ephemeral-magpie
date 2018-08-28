#!/bin/bash

# This file is a mix of these two files : 
# - https://github.com/Accenture/serverless-ephemeral/blob/master/src/lib/packager/tensorflow/scripts/build.sh
# - https://github.com/ryfeus/lambda-packs/blob/master/Tensorflow/buildPack_py3.sh


. /venv3/bin/activate && pip3 install --no-binary scipy scipy==0.19.0 && pip3 install git+https://github.com/inspirehep/magpie.git@v2.0 && pip3 install tensorflow==1.4.0
# Add __init__.py because of this issue https://github.com/tensorflow/tensorflow/issues/3086

touch /venv3/lib/python3.6/site-packages/google/__init__.py
pip3 uninstall -y enum34 && deactivate 

#cd /venv3/lib/python3.6/site-packages/

find /venv3/lib/python3.6/site-packages/tensorflow/python -name "*.so" | xargs strip;

for dir in "/venv3/lib/python3.6/site-packages/"
do
  cd "/venv3/lib/python3.6/site-packages/"
    find -name "*.so" | xargs strip
    #find -name "*.so.*" | xargs strip
    find tensorflow/python/ -name "*.so" -exec rm -rf {} +
    find . -name \*.pyc -delete
    find . -name \*.txt -delete
    find . -type d -name "__MACOSX" -exec rm -rf {} +
    find . -type d -name "unsupported" -exec rm -rf {} +
    find . -type d -name "thirdparty" -exec rm -rf {} +
    find . -type d -name "external" -exec rm -rf {} +
    find . -type d -name "tensorboard" -exec rm -rf {} +
    find . -type d -name "*_tensorboard*" -exec rm -rf {} +
    find . -type d -name "easy_install" -exec rm -rf {} +
    find . -type d -name "licenses" -exec rm -rf {} +
    find . -type d -name "wheel*" -exec rm -rf {} +
    find . -type d -name "pip*" -exec rm -rf {} +
    find . -type d -name "windows" -exec rm -rf {} +
    find . -type d -name "contrib" -exec rm -rf {} +
    find . -type d -name "eigen" -exec rm -rf {} +
    find . -type d -name "Eigen" -exec rm -rf {} +
    find . -type d -name "__pycache__" -exec rm -rf {} +
    find . -type d -name "setuptools*" -exec rm -rf {} +
    find . -type d -name "tutorial*" -exec rm -rf {} +
    find . -type d -name "*.dist-info" -exec rm -rf {} +
    find . -type d -name "*.egg-info" -exec rm -rf {} + 

done
#solution to error error Unable to import module 'handler': liblapack.so.3: cannot open shared object file: No such file or directory : https://github.com/ryansb/sklearn-build-lambda/blob/master/build.sh
mkdir -p /venv3/lib/python3.6/site-packages/lib || true
cp /usr/lib64/atlas/* /venv3/lib/python3.6/site-packages/lib/
cp /usr/lib64/libgfortran.so.3 /venv3/lib/python3.6/site-packages/lib/




# Zip libraries
output=/tmp/lambda-libraries
mkdir -p ${output}
#zip -r9q ${output}/text-classification.zip *
zip -FS -r9 ${output}/text-classification.zip *
