freeStyleJob('build-Jenkins-master-ami') {
    logRotator(-1, 10)
    scm {
        git{
            remote{
                credentials(anil305rgpv)
                url(github.com/anil503rgpv/jenkins-setup.git)
            }
        }
        github('git@github.com:anil503rgpv/jenkins-setup.git', 'master')
    }
    steps {
        shell('make clean build')
    }
    
}