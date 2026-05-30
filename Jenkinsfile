pipeline {

    agent {
        label 'terraform'
    }

    parameters {
        choice(
            name: 'ACTION',
            choices: ['plan', 'apply', 'destroy'],
            description: 'Terraform action'
        )
    }

    environment {
        TF_DIR = 'environments/dev'
        AWS_DEFAULT_REGION = 'ap-southeast-2'
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
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'snehal-aws'
                    ]]) {
                        sh 'terraform init -input=false -backend-config=backend.hcl'
                    }
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir("${env.TF_DIR}") {
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'snehal-aws'
                    ]]) {
                        sh 'terraform validate'
                    }
                }
            }
        }

        stage('Terraform Plan') {
            when {
                expression {
                    params.ACTION == 'plan' || params.ACTION == 'apply'
                }
            }

            steps {
                dir("${env.TF_DIR}") {
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'snehal-aws'
                    ]]) {
                        sh 'terraform plan -input=false -out=tfplan'
                    }
                }
            }
        }

        stage('Terraform Apply') {
            when {
                expression {
                    params.ACTION == 'apply'
                }
            }

            steps {
                dir("${env.TF_DIR}") {

                    input(
                        message: 'Apply Terraform changes to AWS?',
                        ok: 'Apply'
                    )

                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'snehal-aws'
                    ]]) {
                        sh 'terraform apply -input=false tfplan'
                    }
                }
            }
        }

        stage('Terraform Destroy') {
            when {
                expression {
                    params.ACTION == 'destroy'
                }
            }

            steps {
                dir("${env.TF_DIR}") {

                    input(
                        message: 'Destroy ALL Terraform resources?',
                        ok: 'Destroy'
                    )

                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'snehal-aws'
                    ]]) {
                        sh 'terraform destroy -input=false -auto-approve'
                    }
                }
            }
        }
    }

    post {

        success {
            emailext(
                subject: "SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """
Build Success!

Job Name: ${env.JOB_NAME}
Build Number: ${env.BUILD_NUMBER}

Build URL:
${env.BUILD_URL}
""",
                to: "snehaldighore21@gmail.com"
            )
        }

        failure {
            emailext(
                subject: "FAILED: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """
Build Failed!

Job Name: ${env.JOB_NAME}
Build Number: ${env.BUILD_NUMBER}

Build URL:
${env.BUILD_URL}
""",
                to: "snehaldighore21@gmail.com"
            )
        }

        always {
            dir("${env.TF_DIR}") {
                sh 'rm -f tfplan || true'
            }
        }
    }
}
