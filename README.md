# Sources with Dockerfile to assemble the docker image.


## Login as developer
`oc login -u developer https://api.crc.testing:6443`

## Create a new project
`oc new-project nitish`

## Configure image registry
`oc patch configs.imageregistry.operator.openshift.io cluster --type merge --patch '{"spec":{"managementState":"Managed"}}`
`oc patch configs.imageregistry.operator.openshift.io cluster --type merge --patch '{"spec":{"storage":{"emptyDir":{}}}}`
`oc patch configs.imageregistry.operator.openshift.io/cluster --patch '{"spec":{"defaultRoute":true}}' --type=merge`

## Create an image stream
`oc import-image nitish --from=quay.io/tdonohue/python-hello-world:latest --confirm`

## Create a build
`oc apply -f openshift/build-config.yaml -n nitish`

##  Run Build
`oc start-build result`

## Get Builds
`oc get build`

## Describe Build
`oc describe build <build_name>`

## Create Deployment
`oc apply -f openshift/deployment.yaml`

# Openshift Pipeline
Below are the steps to perform build and deploy via Openshift Pipelines (using Tekton)

1. Install Openshift operator  
    `oc apply -f openshift/pipelines/sub.yaml`

2. Create Project  
    `oc new-project pipeline-tutorial`

3. Grant "pipeline" service account right to your project
   `oc adm policy add-scc-to-user privileged -z pipeline` 
   `oc adm policy add-role-to-user edit -z pipeline`  

4. Configure pipeline resolver  
    `oc apply -f openshift/pipeline\tekton_config.yml`

5. Create a PVC  
    `oc apply -f openshift/pipeline/pvc.yaml`  

6. Create custom tasks "apply-manifest" and "update-manifest"
    `oc apply -f openshift/pipeline/apply_manifest_task.yaml`  
    `oc apply -f openshift/pipeline/update_deployment_task.yaml`  

7. Create Openshift Pipeline  
    `oc apply -f openshift/pipeline/pipeline.yaml`


