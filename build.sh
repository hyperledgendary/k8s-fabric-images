#!/bin/bash

set -e -u -o pipefail

ROOT_DIR="$(cd "$(dirname "$0")/." && pwd)"
: ${GO_VER:=1.16.7}
: ${ALPINE_VER:=3.14}

mkdir -p ${ROOT_DIR}/build_context/fabric
mkdir -p ${ROOT_DIR}/build_context/fabric-ca

curl -sSL https://github.com/hyperledger/fabric/releases/download/v2.4.0/hyperledger-fabric-linux-amd64-2.4.0.tar.gz | tar xzf - -C ${ROOT_DIR}/build_context/fabric
curl -sSL https://github.com/hyperledger/fabric-ca/releases/download/v1.5.2/hyperledger-fabric-ca-linux-amd64-1.5.2.tar.gz | tar xzf - -C /${ROOT_DIR}/build_context/fabric-ca

# copy over the preferred config for k8s
# note this does overwrite rather than merge the core configuration
cp ${ROOT_DIR}/k8s_preferred_config/core.yaml ${ROOT_DIR}/build_context/fabric/config/core.ymal

# build the ccaas builder
cd ${ROOT_DIR}/ccaas_builder 
go test -v ./cmd/detect && go build -o ${ROOT_DIR}/build_context/ccaas_builder/bin/ ./cmd/detect/
go test -v ./cmd/build && go build -o ${ROOT_DIR}/build_context/ccaas_builder/bin/ ./cmd/build/
go test -v ./cmd/release && go build -o ${ROOT_DIR}/build_context/ccaas_builder/bin/ ./cmd/release/
cd ${ROOT_DIR}

# build the required images
for i in ${ROOT_DIR}/images/*/; do
    
    binname=$(basename $i)
    echo "::"
	echo ":: Building ${binname}"
	echo "::"
    docker build -f ${i}/Dockerfile -t hyperledger/k8s-fabric-${binname} ./build_context
done 


docker images | grep "hyperledger/k8s"
	# $(DBUILD) -f images/$*/Dockerfile \
	# 	--build-arg GO_VER=$(GO_VER) \
	# 	--build-arg ALPINE_VER=$(ALPINE_VER) \
	# 	$(BUILD_ARGS) \
	# 	-t $(DOCKER_NS)/fabric-$*
