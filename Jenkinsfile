pipeline {
  agent {
     node { 
        label 'CentOS9_x86_64'
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
      mail(to: 'cjw@ucar.edu cdewerd@ucar.edu janine@ucar.edu', subject: 'aircraft_caledit Jenkins build failed', body: 'aircraft_caledit Jenkins build failed')
    }
  }
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
}
