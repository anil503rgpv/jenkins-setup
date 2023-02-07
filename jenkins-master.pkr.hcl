source "amazon-ebs" "basic-example" {
  region =  "ap-south-1"
  source_ami = "ami-01a4f99c4ac11b03c"
  instance_type =  "m5a.large"
  associate_public_ip_address = true
  ssh_clear_authorized_keys = true
  #ssh_agent_auth = true
  #ssh_keypair_name = "jenkins"
  ssh_username =  "ec2-user"
  ami_name =  "jenkins-master-{{timestamp}}"
  tags = {
      managedBy = "DevOps"
      usedBy = "YouTube"
      name = "jenkins-master-{{timestamp}}"
  }
}

build {
  sources = [
    "source.amazon-ebs.basic-example"
  ]

//   provisioner "shell" {
//     inline = ["echo Connected via SSM at '${build.User}@${build.Host}:${build.Port}'"]
//   }

  provisioner "ansible" {
      playbook_file = "./jenkins-master.yml"
    }
}


