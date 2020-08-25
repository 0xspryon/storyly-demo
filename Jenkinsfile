pipeline {
    agent none

    stages {
      // stage('Build and test') {
      //   agent {
      //     docker {
      //       image 'cypress/base:12.16.1'
      //       args '-p 3000:3000'
      //     }
      //   }
      //   steps {
      //       sh 'npm ci'
      //       sh 'npm run e2e dashboard-e2e'
      //   }

      // }

      stage('Build image Dashboard') {
          /* This builds the actual image; synonymous to
           * docker build on the command line */
           steps {
             script {
              app = docker.build("gcr.io/dashboard", "./Dashboard_Dockerfile")
             }
           }
      }



    /*stage('Sanity check') {
     *     containerID = sh (
     *        script: "docker run -d gcr.io/production-220423/pre-emploi-patternfly:latest",
     *    returnStdout: true
     *   ).trim()
     *    echo "Container ID is ==> ${containerID}"
     *    sh "docker stop ${containerID}"
     *    sh "docker rm ${containerID}"
     }*/



    stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
         steps {
          script {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
          }
         }
    }
  }

}
