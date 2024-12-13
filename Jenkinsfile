#node {
   # def app
     #   stage('Clone') {
	     #   checkout scm
		 #   }
		     #   stage('Build image') {
			   #     // Construction de l'image Docker
				   #     app = docker.build("adams/nginx")
					#    }
					    #    stage('Run image') {
						 #       // Exécution de l'image Docker avec le mapping de ports correct
							 #       app.withRun('-p 3000:80') { c ->
								    #        sh 'docker ps'
									            #    sh 'curl localhost:3000'
											       # }
												   # }
												   # }


pipeline {
    agent any

    environment {
        GITHUB_REPO = 'https://github.com/lip33699/jenkins-build-docker.git'
        GITLAB_REPO = 'https://gitlab.com/adams284743/Presentations-Jenkins.git'
        GITLAB_CREDENTIALS_ID = 'gitlab-username-password'
    }

    stages {
        stage('Clone GitHub Repository') {
            steps {
                script {
                    // Clone le dépôt GitHub
                    git url: GITHUB_REPO, branch: 'master'
                }
            }
        }

        stage('Add GitLab Remote') {
            steps {
                script {
                    // Vérifier si le remote GitLab existe déjà
                    def gitRemoteExists = sh(script: "git remote get-url gitlab", returnStatus: true)
                    if (gitRemoteExists != 0) {
                        // Si le remote GitLab n'existe pas, on l'ajoute
                        sh 'git remote add gitlab https://gitlab.com/adams284743/Presentations-Jenkins.git'
                    } else {
                        echo 'Le remote gitlab existe déjà.'
                    }
                }
            }
        }

        stage('Pull from GitLab') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: GITLAB_CREDENTIALS_ID, usernameVariable: 'GITLAB_USER', passwordVariable: 'GITLAB_TOKEN')]) {
                        sh 'git config pull.rebase false'
                        sh 'git fetch origin'
                        sh 'git reset --hard origin/master'
                        sh 'git pull origin master'
                    }
                }
            }
        }

        stage('Create New Branch') {
            steps {
                script {
                    // Créer une nouvelle branche pour éviter de forcer sur master
                    sh 'git checkout -b new-branch'
                }
            }
        }

        stage('Push to GitLab') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: GITLAB_CREDENTIALS_ID, usernameVariable: 'GITLAB_USER', passwordVariable: 'GITLAB_TOKEN')]) {
                        // Pousser la nouvelle branche sur GitLab
                        sh "git push https://${GITLAB_USER}:${GITLAB_TOKEN}@gitlab.com/adams284743/Presentations-Jenkins.git new-branch"
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Dépôt transféré avec succès de GitHub vers GitLab.'
        }
        failure {
            echo 'Le transfert du dépôt a échoué.'
        }
    }
}


