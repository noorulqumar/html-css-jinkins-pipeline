pipeline {   
   agent any
   environment {     
    DockerHub= credentials('DockerHub')   
    Account='noorulqumar80'
    RepoName="myapp"
    } 
  stages {         
    stage("Git Checkout"){  
    steps{     
	checkout([
                    $class: 'GitSCM', 
                    branches: [[name: '*/main']], 
                    userRemoteConfigs: [[url: 'https://github.com/noorulqumar/html-css-jinkins-pipeline.git']]
                ])
    	sh 'pwd'
    	echo 'Git Checkout Completed'   
    	sh 'ls ${pwd}'
    }
}
    stage("Test The Code Quality")
    {
        steps{
            sh 'echo here we will test code'
        }
    }
    stage("Build Docker Image")
    {
        steps{
            sh 'docker build --tag $Account/$RepoName:$BUILD_NUMBER .'
            sh 'echo Image Build Successfully' 
        }
    }
    stage("Show Docker Image")
    {
        steps{
            
            sh 'docker images' 
        }
    }
    stage('Login to Docker Hub') {         
      steps{           
        sh 'echo $USER'
    	sh 'echo $DockerHub | docker login -u noorulqumar80 --password-stdin'                 
    	echo 'Login Completed'                
      }           
    }
    stage("Push Image To DockerHub")
    {
        steps{
            sh 'docker push $Account/$RepoName:$BUILD_NUMBER'
            sh 'echo Image Pushed Successfully' 
        }
    }
    stage('Login to ECR') {         
      steps{           
        sh 'echo $USER'
    	sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 927600130472.dkr.ecr.us-east-1.amazonaws.com'                 
    	echo 'Login TO ECR Completed'                
      }           
    }
    stage("Push Image To ECR")
    {
        steps{
            sh 'docker tag $Account/$RepoName:$BUILD_NUMBER 927600130472.dkr.ecr.us-east-1.amazonaws.com/$RepoName:$BUILD_NUMBER'
            sh 'docker push 927600130472.dkr.ecr.us-east-1.amazonaws.com/$RepoName:$BUILD_NUMBER'
            sh 'echo Image Pushed To ECR Successfully' 
        }
    } 
  } //stages 
  post{
    always {  
      sh 'docker logout'           
    }      
  }  
} //pipeline
