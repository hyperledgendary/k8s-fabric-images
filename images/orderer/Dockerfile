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

COPY ./fabric/bin/orderer /usr/local/bin
COPY ./fabric/config/orderer.yaml ${FABRIC_CFG_PATH}/
COPY ./fabric/config/configtx.yaml ${FABRIC_CFG_PATH}/

EXPOSE 7050
CMD ["orderer"]
