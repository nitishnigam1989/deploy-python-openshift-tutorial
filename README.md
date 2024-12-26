# Sources with Dockerfile to assemble the docker image.


## Login as developer
oc login -u kubeadmin <openshift_url>

## Create a new project
oc new-project nitish

## Create an image stream
oc import-image nitish --from=quay.io/tdonohue/python-hello-world:latest --confirm

## Create a build
oc apply -f openshift/build-config.yaml -n nitish

##  Run Build
oc start-build test

## Get Builds
oc get build

## Describe Build
oc describe build <build_name>

## Create Deployment
oc apply -f openshift/deployment.yaml