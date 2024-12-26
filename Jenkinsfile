pipeline {
    options {
        // set a timeout of 60 minutes for this pipeline
        timeout(time: 60, unit: 'MINUTES')
    }

    environment {
        APP_NAME = "test"
        DEV_PROJECT = "nitish"
        //STAGE_PROJECT = "windfire-stage"
        //PROD_PROJECT = "windfire-prod"
        APP_GIT_URL = "https://github.com/nitishnigam1989/deploy-python-openshift-tutorial.git"
    }

    agent {
        node {
            label 'hello-world'
        }
    }

    stages {
        stage('Deploy to DEV environment') {
            steps {
                echo '###### Deploy to DEV environment ######'
                script {
                    openshift.withCluster() {
                        openshift.withProject("$DEV_PROJECT") {
                            echo "Using project: ${openshift.project()}"
                            // If BuildConfig already exists, start a new build to update the application
                            if (openshift.selector("bc", APP_NAME).exists()) {
                                echo "BuildConfig " + APP_NAME + " exists, start new build to update app ..."
                                // Start new build (it corresponds to oc start-build <buildconfig>)
                                def bc = openshift.selector("bc", "${APP_NAME}")
                                bc.startBuild()
                                // If a Route does not exist, expose the Service and create the Route
                                if (!openshift.selector("route", APP_NAME).exists()) {
                                    echo "Route " + APP_NAME + " does not exist, exposing service ..." 
                                    def service = openshift.selector("service", APP_NAME)
                                    service.expose()
                                }
                            }
                            // If BuildConfig does not exist, deploy a new application using an OpenShift Template
                            else {
                                echo "BuildConfig " + APP_NAME + " does not exist, creating app ..."
                                openshift.newApp('openshift/build-configyaml')
                            }
                            def route = openshift.selector("route", APP_NAME)
                            echo "Test application with "
                            def result = route.describe()
                        }
                    }
                }
            }
        }
    }
}
