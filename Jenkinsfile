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
    success {
      mail(to: 'cjw@ucar.edu cdewerd@ucar.edu janine@ucar.edu taylort@ucar.edu', subject: 'aircraft_caledit Jenkinsfile build successful', body: 'aircraft_caledit Jenkinsfile build successful')
    }
  }
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
}
