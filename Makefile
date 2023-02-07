# The name of the EC2 AMI to build
AMI_NAME = jenkins-master

# The AWS profile to use for the build
AWS_PROFILE = default

# The region to build the AMI in
REGION = us-west-2

.PHONY: all
all: build

.PHONY: init
init: packer init .

.PHONY: build
build: init
	packer build \
		jenkins-master.pkr.hcl

.PHONY: clean
clean:
	$(RM) -r output-*
