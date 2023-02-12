source "amazon-ebs" "jenkins-master" {
  access_key = "{{env `AWS_ACCESS_KEY_ID`}}"
  secret_key = "{{env `AWS_SECRET_ACCESS_KEY`}}"
  region =  "ap-south-1"
  source_ami = "ami-01a4f99c4ac11b03c"
  instance_type =  "m5a.large"
  associate_public_ip_address = true
  ssh_clear_authorized_keys = true
  #ssh_agent_auth = true
  #ssh_keypair_name = "jenkins"
  ssh_username =  "ec2-user"
  ami_name =  "jenkins-master-{{timestamp}}"

  // launch_block_device_mappings {
  //   device_name = "/dev/sda1"
  //   volume_size = 40
  //   volume_type = "gp2"
  //   delete_on_termination = true
  // }

  tags = {
      managedBy = "DevOps"
      usedBy = "YouTube"
      name = "jenkins-master-{{timestamp}}"
  }
}

build {
  sources = [
    "source.amazon-ebs.jenkins-master"
  ]

//   provisioner "shell" {
//     inline = ["echo Connected via SSM at '${build.User}@${build.Host}:${build.Port}'"]
//   }

  provisioner "ansible" {
      playbook_file = "./ansible/jenkins-master.yml"
    }
}


