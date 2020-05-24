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

		stage('Push image') {
			steps{
				withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
					sh './docker_upload.sh'
				}
			}
		}

		stage('set kubectl context') {
			steps{
				withAWS(region:'us-east-2',credentials:'aws_access_key_id') {
					sh '''
					aws eks --region us-east-2 update-kubeconfig --name prod
					kubectl config use-context arn:aws:eks:us-east-2:223008900821:cluster/prod
					'''
				}
			}
		}

		stage('Deploy blue controller') {
			steps{
				withAWS(region:'us-east-2',credentials:'aws_access_key_id') {
					sh 'kubectl apply -f ./blue-controller.yaml'
				}
			}
		}

		stage('Deploy green controller') {
			steps{
				withAWS(region:'us-east-2',credentials:'aws_access_key_id') {
					sh 'kubectl apply -f ./green-controller.yaml'
				}
			}
		}
		
		stage('Create loadbalancer service') {
			steps{
				withAWS(region:'us-east-2',credentials:'aws_access_key_id') {
					sh 'kubectl apply -f ./service.yaml'
				}
			}
		}

		stage('Clean') {
			steps{
				withAWS(region:'us-east-2',credentials:'aws_access_key_id') {
					sh 'docker system prune'
				}
			}
		}

	}
}