freeStyleJob('build-Jenkins-master-ami') {
    logRotator(-1, 10)
    scm {
        git{
            remote{
                credentials(anil305rgpv)
                url(https://github.com/anil503rgpv/jenkins-setup.git)
            }
        }
        
    }
    steps {
        shell('make clean build')
    }
    
}