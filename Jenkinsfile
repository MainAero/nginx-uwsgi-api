node {
    def image = ''

    stage('Git checkout') {
        /* Checkout the code we are currently running against */
        checkout scm
    }

    stage('Docker build') {
        /* Build the Docker image with a Dockerfile, tagging it with the build number */
        image = docker.build "uwsgi:${env.BUILD_NUMBER}"
    } 

    stage('Test') {
        image.inside() {
            sh "pip install -r requirements-dev.txt && pip install -r requirements.txt"
            sh "nosetests tests/*"
        }
    }

    stage('Docker push') {
        /* Push the docker image to the registry with tags latest and build number */
        docker.withRegistry('registry', 'credentials') {
            image.push 'latest'
            image.push "${env.BUILD_NUMBER}"
        }
    }
}
