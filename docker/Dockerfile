FROM sach97/serephem-venv:python3.6
#FROM lambci/lambda:python3.6
#FROM amazonlinux:latest
# RUN yum update -y && yum upgrade && yum install -y \
# git \
# python36-devel \
# python36-setuptools \
# easy_install-3.6 pip

#RUN pip3 install git+https://github.com/inspirehep/magpie.git@v2.0

COPY scripts/build.sh scripts/build.sh
RUN chmod +x scripts/build.sh
CMD [ "scripts/build.sh" ]
