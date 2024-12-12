node {
    def app
        stage('Clone') {
	        checkout scm
		    }
		        stage('Build image') {
			        // Construction de l'image Docker
				        app = docker.build("adams/nginx")
					    }
					        stage('Run image') {
						        // Exécution de l'image Docker avec le mapping de ports correct
							        app.withRun('-p 3000:80') { c ->
								            sh 'docker ps'
									                sh 'curl localhost:3000'
											        }
												    }
												    }

