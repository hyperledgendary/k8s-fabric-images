# k8s-fabric-images

The docker images produced from the main hyperledger/fabric repository are examples of how a docker image could be created with Fabric's binaries.

This repo is exploring the considerations of how to take the binaries built from Fabric, and then packaged them specifically targeted at a K8S environment.

## To create the images

Prereqs: requires as go build environment

Run `build.sh`

## TODO

[ ] Add the FabricCA
[ ] What else could be added to the images for K8S eg monitoring
[ ] Preconfigure for Metrics
