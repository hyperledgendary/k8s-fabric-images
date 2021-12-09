# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0

FROM ubuntu:latest as peer-base

ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* 


ENV FABRIC_CFG_PATH /etc/hyperledger/fabric
VOLUME /etc/hyperledger/fabric
VOLUME /var/hyperledger

COPY ./fabric/bin/peer /usr/local/bin/peer
COPY ./fabric/config/core.yaml ${FABRIC_CFG_PATH}/core.yaml
COPY ./ccaas_builder/bin/ /opt/hyperledger/ccaas_builder/bin/

EXPOSE 7051
CMD ["peer","node","start"]
