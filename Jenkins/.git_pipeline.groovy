pipeline {
    agent any 
    stages {
	stage('Cleanup') {
	     steps {

		deleteDir()
 	      }	
	}
        stage('Checkout') { 
            steps {
		git 'https://github.com/art200109/project/'
            }
      }
    }
}
