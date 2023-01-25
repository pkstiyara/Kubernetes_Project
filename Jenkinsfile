pipeline {
    agent any

    stages {
        stage('Git Checkout') {
            steps {
                git 'https://github.com/pkstiyara/Kubernetes_Project.git'
            }
          }
        stage('Sending docker file to Ansible Server'){
            steps {
            sshagent(['ansible']) {
                sh 'ssh -o StrictHostKeyChecking=no ubuntu@52.91.203.3'
                sh 'scp /var/lib/jenkins/workspace/demo/* ubuntu@52.91.203.3:/home/ubuntu'
            }
          }
        }
        
        stage('Docker Build Image') {
            steps {
            sshagent(['ansible']) {
             sh 'ssh -o StrictHostKeyChecking=no ubuntu@52.91.203.3 cd /home/ubuntu'
             sh 'ssh -o StrictHostKeyChecking=no ubuntu@52.91.203.3 sudo docker image build -t $JOB_NAME:v1.$BUILD_ID .'
         }
        }
      }
        stage ('Docker Image Tagging'){
            steps {
            sshagent(['ansible']) {
             sh 'ssh -o StrictHostKeyChecking=no ubuntu@52.91.203.3 cd /home/ubuntu/'
             sh 'ssh -o StrictHostKeyChecking=no ubuntu@52.91.203.3 sudo docker image tag $JOB_NAME:v1.$BUILD_ID pkstiyara/$JOB_NAME:v1.$BUILD_ID'
             sh 'ssh -o StrictHostKeyChecking=no ubuntu@52.91.203.3 sudo docker image tag $JOB_NAME:v1.$BUILD_ID pkstiyara/$JOB_NAME:latest'
                
            }    
          }
        }
        
        stage('push docker images to docker hub'){
            steps {
            sshagent(['ansible']) {
                withCredentials([string(credentialsId: 'dockerhub_passwd', variable: 'dockerhub_passwd')]) {
                sh  "ssh -o StrictHostKeyChecking=no ubuntu@52.91.203.3 sudo -S docker login -u pkstiyara -p ${dockerhub_passwd}"
                sh 'ssh -o StrictHostKeyChecking=no ubuntu@52.91.203.3 sudo docker image push pkstiyara/$JOB_NAME:v1.$BUILD_ID'
                sh 'ssh -o StrictHostKeyChecking=no ubuntu@52.91.203.3 sudo docker image push pkstiyara/$JOB_NAME:latest'
                
                sh 'ssh -o StrictHostKeyChecking=no ubuntu@52.91.203.3 sudo docker image rm pkstiyara/$JOB_NAME:v1.$BUILD_ID pkstiyara/$JOB_NAME:latest $JOB_NAME:v1.$BUILD_ID'
                    
                }
              }
            }
          }
        
        stage('Copy files from Jenkins server to Kubernetes Cluster Server'){
            steps {
            sshagent(['ansible']) {
                sh 'ssh -o StrictHostKeyChecking=no ubuntu@35.175.190.135'
                sh 'scp /var/lib/jenkins/workspace/demo/* ubuntu@35.175.190.135:/home/ubuntu'
            }
           }
         }
        stage('Kubernetes Deployment using ansible')  {
            steps {
            sshagent(['ansible']) {
                sh 'ssh -o StrictHostKeyChecking=no  ubuntu@52.91.203.3 cd /home/ubuntu'
                sh 'ssh -o StrictHostKeyChecking=no  ubuntu@52.91.203.3 sudo ansible -m ping node'
                sh 'ssh -o StrictHostKeyChecking=no  ubuntu@52.91.203.3 sudo ansible-playbook ansible.yml'
            }    
            }
        }
         
       }
     }
