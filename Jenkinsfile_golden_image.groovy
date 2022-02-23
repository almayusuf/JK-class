node {
	stage("Clone a Repo"){
        checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/farrukh90/jenkins-class.git']]])
	
	}
	stage("Validate"){
		ws("${workspace}/packer/pipelines/tools"){
			sh "packer validate golden_image.json"
		}
	}
	stage("Build Image"){
		ws("${workspace}/packer/pipelines/tools"){
			sh "packer build golden_image.json"
		}
	}
	stage("Send Notification"){
			echo "Hello"
	}
}