pipeline {
    agent { label 'slave'}
    
    environment {
    	image_version="latest" }
   
	stages {

	       
        stage("code"){
            steps{
                git url: "https://github.com", branch: "main"
                echo 'Successfuly fetch the code for central repo '
        	 }
         	     }
        stage("build and test"){
            steps{
                sh "docker build -t node-todo ."
                echo 'Successfull build docker image from the dockerfile'
                 }
              		       }  
     
        stage("push"){
            steps{
                withCredentials([usernamePassword(credentialsId: 'dockerhubid', passwordVariable: 'password', usernameVariable: 'username')]){
                sh "docker login -u ${env.username} -p ${env.password}"
                sh "docker tag node-todo ${env.username}/node-todo:latest"
                sh "docker push ${env.username}/node-todo:latest"
                echo 'Successfully pushed the image to dockerHub'
                }
            	}
          	     }	

	    
        stage("deploying with docker compose"){
	    steps{
                sh "docker-compose down && docker-compose up -d"
                echo 'Successfully deployed with docker-compose'
              }
         	  }
        
		stage("deploying on EKS cluster"){
            input {
	          message "should i deploy on cluster??"
		      ok "yes, Proceed with deployment" }
	        steps{
                sh "kubectl apply -f deployment.yml -f service.yml"
                echo 'Successfully deploy on EKS cluster'
                 }
         	}    
	
	} //All stages end here


    post{
    	success{ 
		echo 'successfully docntainerize and deployed the application'
	       }

	failure{
		echo 'failed to deploy'
	       }
	always{
		echo 'pipeline execution completed'
	      }

	}//post build actions ends

	
}//pipeline execution ends
