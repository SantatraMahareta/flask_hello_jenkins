pipeline {
  agent {
    kubernetes {
      namespace 'jenkins' // Specify the namespace explicitly
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
      image: python:3.11-slim
      command:
        - cat
      tty: true
      resources:
        limits:
          cpu: "500m"
          memory: "512Mi"
        requests:
          cpu: "200m"
          memory: "256Mi"
    - name: jnlp
      image: jenkins/inbound-agent:4.11.2-4
      args:
        - \${computer.jnlpmac}
        - \${computer.name}
      resources:
        limits:
          cpu: "500m"
          memory: "512Mi"
        requests:
          cpu: "100m"
          memory: "128Mi"
"""
    }
  }
  stages {
    stage('Test python') {
      steps {
        container('python') {
          retry(3) {
            sh 'pip install -r requirements.txt'
            sh 'python test.py'
          }
        }
      }
    }
  }
}