# Sources with Dockerfile to assemble the docker image.


## Login as developer
oc login -u developer https://api.crc.testing:6443

## Create a new project
oc new-project nitish

## Day 2 Operation
oc patch configs.imageregistry.operator.openshift.io cluster --type merge --patch '{"spec":{"managementState":"Managed"}} 
oc patch configs.imageregistry.operator.openshift.io cluster --type merge --patch '{"spec":{"storage":{"emptyDir":{}}}}
oc patch configs.imageregistry.operator.openshift.io/cluster --patch '{"spec":{"defaultRoute":true}}' --type=merge

## Create an image stream
oc import-image nitish --from=quay.io/tdonohue/python-hello-world:latest --confirm

## Create a build
oc apply -f openshift/build-config.yaml -n nitish

##  Run Build
oc start-build result

## Get Builds
oc get build

## Describe Build
oc describe build <build_name>

## Create Deployment
oc apply -f openshift/deployment.yaml

