node("ondemand") {
    checkout scm
    //docker.image('drush/drush:8').inside {
    //    sh "drush --version"
    //}
    def drudock = docker.build 'drudock:snapshot'
    drudock.inside {
      sh 'docman --version'
    }
}
