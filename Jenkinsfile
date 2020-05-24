pipeline{
	agent any
	stages{
		stage ('Lint HTML'){
			steps{
				sh 'tidy -q -e *.html'
			}
		}

		stage('Build image') {
			steps{
				sh 'echo "Building image"'
				sh './docker_run.sh'
			}
		}

	}
}