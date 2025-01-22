#!/bin/bash

# Namespace and application details
NAMESPACE="default"

# Function to check pod status
check_pods() {
  echo "Checking pod status in namespace $NAMESPACE..."
  kubectl get pods -n $NAMESPACE
  echo
}

# Function to describe pods with issues
describe_unhealthy_pods() {
  echo "Describing unhealthy pods..."
  UNHEALTHY_PODS=$(kubectl get pods -n $NAMESPACE --no-headers | grep -v Running | awk '{print $1}')
  if [ -z "$UNHEALTHY_PODS" ]; then
    echo "All pods are healthy."
  else
    for POD in $UNHEALTHY_PODS; do
      echo "Describing pod $POD..."
      kubectl describe pod $POD -n $NAMESPACE
      echo
    done
  fi
}

# Function to check services
check_services() {
  echo "Checking services in namespace $NAMESPACE..."
  kubectl get svc -n $NAMESPACE
  echo
}

# Function to test ingress connectivity
check_ingress() {
  echo "Testing ingress connectivity in namespace $NAMESPACE..."
  
  # Get all ingress URLs in the namespace
  INGRESS_URLS=$(kubectl get ingress -n $NAMESPACE --no-headers | awk '{print $3}')
  
  if [ -z "$INGRESS_URLS" ]; then
    echo "No ingress URLs found."
  else
    for URL in $INGRESS_URLS; do
      echo "Testing ingress at $URL..."
      curl -I https://$URL
    done
  fi
  echo
}


# Function to check logs for errors
check_logs() {
  echo "Checking logs for errors..."
  kubectl logs -l app.kubernetes.io/name=vikunja -n $NAMESPACE | grep -i "error"
  echo
}

# Function to check resource usage
check_resource_usage() {
  echo "Checking resource usage for pods..."
  kubectl top pods -n $NAMESPACE
  echo
}

# Function to troubleshoot a specific pod
troubleshoot_pod() {
  echo "Enter the name of the pod to troubleshoot:"
  read POD_NAME
  echo "Describing pod $POD_NAME..."
  kubectl describe pod $POD_NAME -n $NAMESPACE
  echo "Fetching logs for $POD_NAME..."
  kubectl logs $POD_NAME -n $NAMESPACE
  echo
}

# Menu-driven interface
while true; do
  echo "========================="
  echo "Vikunja Monitoring Tool"
  echo "========================="
  echo "1. Check pod status"
  echo "2. Describe unhealthy pods"
  echo "3. Check services"
  echo "4. Test ingress connectivity"
  echo "5. Check logs for errors"
  echo "6. Check resource usage"
  echo "7. Troubleshoot a specific pod"
  echo "8. Exit"
  echo "Enter your choice:"
  read CHOICE

  case $CHOICE in
    1) check_pods ;;
    2) describe_unhealthy_pods ;;
    3) check_services ;;
    4) check_ingress ;;
    5) check_logs ;;
    6) check_resource_usage ;;
    7) troubleshoot_pod ;;
    8) echo "Exiting..."; exit 0 ;;
    *) echo "Invalid choice. Please try again." ;;
  esac
done

