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
    component: ci
spec:
  tolerations: # Tolerations pour éviter les problèmes de taints
  - key: "node.kubernetes.io/not-ready"
    operator: "Exists"
    effect: "NoSchedule"
  - key: "node.kubernetes.io/unreachable"
    operator: "Exists"
    effect: "NoSchedule"
  containers:
    - name: python
      image: python:3.11-slim
      command:
        - cat
      tty: true
      resources:
        limits:
          cpu: "200m"
          memory: "256Mi"
        requests:
          cpu: "100m"
          memory: "128Mi"
    - name: jnlp
      image: jenkins/inbound-agent:4.11.2-4
      resources:
        limits:
          cpu: "200m"
          memory: "256Mi"
        requests:
          cpu: "100m"
          memory: "128Mi"
      env:
      - name: JENKINS_URL
        value: "http://192.168.1.100:32000" # URL de Jenkins mise à jour
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