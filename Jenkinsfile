pipeline {
    agent any
    
    environment {
    	tag="v1.0" }
   
	stages {
        
        stage("code"){
            steps{
                git url: "https://github.com/", branch: "main"
                echo 'code clone successfull '
        	 }
         	     }
        stage("build and test"){
            steps{
                sh "docker build -t node-todo ."
                echo 'code build successfull'
                 }
              		       }  
     
        stage("push"){
            steps{
                withCredentials([usernamePassword(credentialsId: 'dockerhubid', passwordVariable: 'password', usernameVariable: 'username')]){
                sh "docker login -u ${env.username} -p ${env.password}"
                sh "docker tag node-todo:${image_version} ${env.username}/node-todo:${image_version}"
                sh "docker push ${env.username}/node-todo:${image_version}"
                echo 'image push successfull'
                }
            	}
          	     }	

	    
        stage("deploy"){
            input {
	          message "should i deploy ??"
		  ok "yes, Proceed with deployment" }
	    steps{
                sh "docker-compose down && docker-compose up -d"
                echo 'deployment done successfully'
                 }
         	}
    }//stages end


    post{
    	success{ 
	       }

	failure{
	       }
	always{
	      }

	}//post ends

	
}//pipeline ends
