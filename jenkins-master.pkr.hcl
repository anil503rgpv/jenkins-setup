source "amazon-ebs" "basic-example" {
  region =  "ap-south-1"
  source_ami =  "ami-02bbd3e40eb247e7e"
  instance_type =  "m5a.large"
  associate_public_ip_address = true
  ssh_clear_authorized_keys = true
  ssh_agent_auth = true
  ssh_keypair_name = "jenkins"
  ssh_username =  "root"
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


  provisioner "ansible" {
      playbook_file = "./jenkins.yml"
    }
}


