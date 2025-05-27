pipeline {
  agent {
    kubernetes {
      label 'jenkins-agent-my-app'
      defaultContainer 'python'
      yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    component: ci
spec:
  containers:
    - name: python
      image: python:3.7
      command:
        - cat
      tty: true
    - name: jnlp
      image: jenkins/inbound-agent:latest
      args:
        - \${computer.jnlpmac}
        - \${computer.name}
"""
    }
  }
  stages {
    stage('Test python') {
      steps {
        container('python') {
          sh 'pip install -r requirements.txt'
          sh 'python test.py'
        }
      }
    }
  }
}
