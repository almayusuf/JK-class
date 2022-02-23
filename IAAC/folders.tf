resource "jenkins_folder" "packer" {
	name = "packer"
	description = "A top-level folder"
}


resource "jenkins_folder" "terraform" {
	name = "terraform"
	description = "A top-level folder"
}
