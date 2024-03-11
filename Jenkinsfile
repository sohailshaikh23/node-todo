pipeline {
    agent any
    
    parameters {
    	strint(name: "image_version", defaultValue: "latest",description: " docker image")       }
    stages {
        
        stage("code"){
            steps{
                git url: "https://github.com/", branch: "main"
                echo 'code clone '
        	 }
         	     }
        stage("build and test"){
            steps{
                sh "docker build -t node-todo ."
                echo 'code build done'
                 }
              		       }  
     
        stage("push"){
            steps{
                withCredentials([usernamePassword(credentialsId:"dockerHub",passwordVariable:"dockerHubPass",usernameVariable:"dockerHubUser")]){
                sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
                sh "docker tag node-todo:${image_version} ${env.dockerHubUser}/node-todo:${image_version}"
                sh "docker push ${env.dockerHubUser}/node-todo:${image_version}"
                echo 'image push'
                }
            	}
          	     }	
        stage("deploy"){
            input {
	          message "should i deploy ??"
		  ok "yes, Proceed with deployment"
		  }
	    steps{
                sh "docker-compose down && docker-compose up -d"
                echo 'deployment done'
                 }
         	       }
    }i


    post{
    	success{
	       }

	failure{
	       }
	always{
	      }


	}
}
