# The name of the EC2 AMI to build
AMI_NAME = jenkins-master

# The AWS profile to use for the build
AWS_PROFILE = default

# The region to build the AMI in
REGION = us-west-2

JENKINS_SSH_KEY = $(shell aws ssm get-parameter --name /youtube/sample/ec2/ssh/jenkins --with-decryption --region ap-south-1 --query Parameter.Value | sed 's/"//g')
ID_RSA_SSH_KEY = $(shell aws ssm get-parameter --name /youtube/sample/github/ssh/id_rsa --with-decryption --region ap-south-1 --query Parameter.Value | sed 's/"//g')


.PHONY: all
all: build

ssh:
	rm -rf /home/ec2-user/ssh_key
	mkdir /home/ec2-user/ssh_key
	@echo $(JENKINS_SSH_KEY) > /home/ec2-user/ssh_key/jenkins
	@echo $(ID_RSA_SSH_KEY) > /home/ec2-user/ssh_key/id_rsa-git
	chmod 755 /home/ec2-user/ssh_key/

init: 
	packer init .

.PHONY: build
build: ssh
	packer build .

# .PHONY: build
# build: 
# 	docker run \
# 		-v `pwd`:/packertemp -w /packertemp \
#     	hashicorp/packer:latest \
#     	build .

.PHONY: clean
clean:
	$(RM) -r output-*
