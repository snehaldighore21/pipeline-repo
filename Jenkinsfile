pipeline {

    agent {
    label 'terraform'
  }

    parameters {
        choice(
            name: 'ACTION',
            choices: ['plan', 'apply'],
            description: 'Terraform action for VPC and EKS'
        )
    }

    environment {
        TF_DIR = 'environments/dev'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                dir("${env.TF_DIR}") {
                    sh 'terraform init -input=false -backend-config=backend.hcl'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir("${env.TF_DIR}") {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir("${env.TF_DIR}") {
                    sh 'terraform plan -input=false -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                dir("${env.TF_DIR}") {
                    input(
                        message: 'Apply VPC and EKS to dev?',
                        ok: 'Apply'
                    )
                    sh 'terraform apply -input=false tfplan'
                }
            }
        }

    }

    post {
        always {
            dir("${env.TF_DIR}") {
                sh 'rm -f tfplan || true'
            }
        }
    }

}
