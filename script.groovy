def buildJar () {
    sh 'mvn package'
}

def buildImg () {
    withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
    sh "docker build -t  $USERNAME/mavenapp:1.0 ."
    sh "$PASSWORD |  docker login -u $USERNAME --password-stdin "
    sh "docker push  $USERNAME/mavenapp:1.0"
                
}

return this
