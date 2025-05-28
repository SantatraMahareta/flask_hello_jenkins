pipeline {
  agent {
    kubernetes {
      namespace 'jenkins' // Namespace explicite
      defaultContainer 'python'
      yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    app: ci-agent
spec:
  tolerations:
  - key: "node.kubernetes.io/not-ready"
    operator: "Exists"
    effect: "NoSchedule"
  - key: "node.kubernetes.io/unreachable"
    operator: "Exists"
    effect: "NoSchedule"
  containers:
    - name: python
      image: python:3.13.3
      command:
        - cat
      tty: true
      resources:
        limits:
          cpu: "200m"
          memory: "512Mi"
        requests:
          cpu: "100m"
          memory: "256Mi"
    - name: jnlp
      image: jenkins/inbound-agent:4.13-2 # Version stable
      resources:
        limits:
          cpu: "200m"
          memory: "512Mi"
        requests:
          cpu: "100m"
          memory: "256Mi"
      env:
      - name: JENKINS_URL
        value: "http://jenkins:8080" # URL interne
      - name: JENKINS_TUNNEL
        value: "jenkins:50000" # Port JNLP interne
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