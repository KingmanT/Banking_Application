pipeline {
  agent any
   stages {
    stage('Init') {
       steps {
         dir('.') {
            sh 'terraform init' 
            }
       }
    }
    stage('Plan') {
       steps {
          dir('.') {
            sh 'terraform plan -out plan.tfplan' 
            }
       }
              
    }
    stage('Apply') {
       steps {
         dir('.') {
           sh 'terraform apply plan.tfplan' 
           }
         }
       }
    }
  }
}
