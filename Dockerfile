FROM thecodingmachine/php:8.2-v4-apache-node20

USER root

RUN apt-get update && apt-get install -y \
    jq

USER docker
