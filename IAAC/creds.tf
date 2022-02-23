resource "jenkins_credential_ssh" "example" {
	name = "ec2-user"
	username = "ec2-user"
	privatekey = file("~/.ssh/id_rsa")
	passphrase = ""
}
