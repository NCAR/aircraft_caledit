pipeline {
  agent {
     node { 
        label 'RHEL7_x86_64'
        } 
  }
  triggers {
  pollSCM('H/30 8-18 * * * ')
  }
  stages {
    stage('Build') {
      steps {
        sh 'scons'
      }
    }
  }
  post {
    failure {
      emailext to: "cjw@ucar.edu janine@ucar.edu cdewerd@ucar.edu taylort@ucar.edu",
      subject: "Jenkinsfile aircraft_caledit build failed",
      body: "See console output attached",
      attachLog: true
    }
  }
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
}
