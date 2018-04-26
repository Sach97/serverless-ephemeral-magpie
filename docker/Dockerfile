FROM lambci/lambda:build-python3.6

COPY scripts/build.sh scripts/build.sh
RUN chmod +x scripts/build.sh

CMD [ "scripts/build.sh" ]