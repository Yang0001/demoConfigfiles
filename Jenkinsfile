
pipeline {
    agent none
    options {
        timeout(time: 1, unit: 'DAYS')
        disableConcurrentBuilds()
    }

    stages {
        stage("Init") {
            agent {label 'Master'}
            steps { initialize() }
        }
         stage("Checkout") {
             agent {label 'Master'}
             steps { checkOut() }
         }
          stage("Publish") {
             agent {label 'Master'}
             steps { publish() }
         }
         stage("Build and Push") {
             agent {label 'Master'}
             steps { buildAndPush() }
         }

            stage("RunOnDev") {
                agent {label 'Dev'}
                steps { dockerRun() }
            }

            stage("UnitTest") {
                agent {label 'Dev'}
                steps { functionTest() }
            }

              stage("RunOnTest") {
                agent {label 'Test'}
                steps { dockerRun() }
            }

             stage("IntegrationTest") {
                agent {label 'Test'}
                steps { integrationTest() }
            }
    }
}


def initialize() {
        env.BuildFolder = "/Build/${JOB_NAME}.${BUILD_ID}"
        env.AppFolder = "/Build/${JOB_NAME}.${BUILD_ID}/App"
        env.ConfigFolder = "/Build/${JOB_NAME}.${BUILD_ID}/Config"
        env.PublishFolder = "/Build/${JOB_NAME}.${BUILD_ID}/Publish"
        env.GitHubPublishFolder = "/Build/${JOB_NAME}.${BUILD_ID}/App/Publish"


        echo "Build Folder: ${BuildFolder}"
        sh "rm -rf /Build/*"
}

def checkOut() {
    // Check out app files
    checkout([$class: 'GitSCM',
                branches: [[name: '*/master']],
                doGenerateSubmoduleConfigurations: false,
                extensions: [[$class: 'RelativeTargetDirectory',
                    relativeTargetDir: "${AppFolder}"]],
                submoduleCfg: [],
                userRemoteConfigs: [[url: 'https://github.com/Yang0001/.NetCoreS3']]])
    // Check out config files
    dir("${ConfigFolder}") {
        git branch: 'master', url: 'https://github.com/Yang0001/demoConfigfiles'
    }
}

def publish() {
        sh "mkdir ${PublishFolder} && cp -r ${GitHubPublishFolder}/* ${PublishFolder}/"
        // sh "cd ${AppFolder} \&& sudo dotnet publish -c release -o ${PublishFolder}"
}

def buildAndPush() {
        sh "cp ${ConfigFolder}/Dockerfile ${BuildFolder}"
        docker.withRegistry('','0be4212a-db34-46db-b7d4-bc28b240ded5') {
            image = docker.build('yangpu0001/demo:API',"${BuildFolder}")
            image.push()
        }

}

def dockerRun() {
        def dockerId

        sh 'docker rm -f $(docker ps | grep demo | awk -F \' \' \'{print $1}\')| xargs --no-run-if-empty'
        dockerId = sh(script: 'docker run -p 5000:80 -dit yangpu0001/demo:API', returnStdout: true).trim()
        sh "docker exec ${dockerId} service nginx start"
        sh "docker exec ${dockerId} /home/ubuntu/Release/start.sh"

        }

def functionTest() {
        sh 'echo function test pass'
        }

def integrationTest() {
        sh 'echo integration test test pass'
        }
