pipeline {
    agent any

    tools {
                  git 'Default'
     }

    parameters{
        choice(
            name: 'ACTION',
            choices: ['apply', 'destroy'],
            description: 'select the action to perform'
        )
    }

    stages{
        stage('Checkout'){
            steps{
               // deleteDir() // 
                sh 'git --version'
                git branch: 'main', url: 'https://github.com/shubhamWithCode/terraform-eks-cluster-nodegroup.git'
            }
        }

        stage('terraform init'){
            steps{
                sh ('terraform init')
            }
        }

        stage("plan"){
            steps{
                sh ('terraform plan')
            }
        }

        stage("Action"){
            steps{
                script{
                    switch(params.ACTION) {
                        case 'apply':
                            echo 'Executing Apply..'
                            sh "terraform apply --auto-approve"
                        break
                        case 'destroy':
                        echo 'Executing destroy ..'
                        sh "terraform destroy --auto-approve"
                        break
                        default:
                        error 'Unknown action'
                    }
                }
            }
        }
    }


}