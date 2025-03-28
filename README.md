

# Todo List Application on Kubernetes

This project deploys a Todo List API using FastAPI on a Kubernetes cluster. It involves setting up a Minikube cluster, configuring persistent storage, horizontal pod autoscaling, and ensuring the application runs properly.


## Pre-requisites

Ensure that you have the following tools installed on your local machine:

- **Minikube**: A tool for running Kubernetes clusters locally.  
  
- **kubectl**: A command-line tool for interacting with Kubernetes clusters.  

- **Docker**: Used for building and pushing container images.  

## Setup Instructions

### 1. Set Up Minikube Cluster

1. **Start Minikube Cluster**:
   ```bash
   minikube start
   ```

2. **Verify the Cluster**: Ensure that Minikube is running:
   ```bash
   kubectl get nodes
   ```

3. **Scale the Cluster**: To add more nodes, run:
   ```bash
   minikube node add
   ```

---

### 2. Build and Push Docker Image

1. **Navigate to the project directory**:
   ```bash
   cd /path/to/your/project
   ```

2. **Build the Docker image**:
   ```bash
   docker build -t tharunrajr/todo-list-fastapi:v1 .
   ```

3. **Push the Docker image to Docker Hub**: Ensure you are logged into Docker Hub:
   ```bash
   docker login
   ```

4. **Push the image**:
   ```bash
   docker push tharunrajr/todo-list-fastapi:v1
   ```

---

### 3. Deploy to Kubernetes

1. **Create Deployment and Service YAML Files**:  
   Create a `deployment.yaml` file in the project directory to configure your Kubernetes deployment.

2. **Create a Service YAML File**:  
   Create a `service.yaml` file to expose the deployment externally.

3. **Create a Horizontal Pod Autoscaler (HPA) YAML File**:  
   Create a `hpa.yaml` file to configure the Horizontal Pod Autoscaler, which automatically adjusts the number of pods based on CPU usage.

4. **Create a ConfigMap YAML file**:  
   Create a `configmap.yaml` file to store configuration values such as environment variables or configuration files.

5. **Create a Secret YAML File**:  
   Create a `secret.yaml` file to store sensitive data like passwords, API keys, or tokens.

6. **Apply the Deployment and Service**:  
   Deploy the application to Kubernetes:
   ```bash
   kubectl apply -f deployment.yaml
   kubectl apply -f service.yaml
   kubectl apply -f hpa.yaml
   kubectl apply -f configmap.yaml
   kubectl apply -f secret.yaml
   ```

---

### 4. Enable Persistent Storage

1. **Create Persistent Volume (PV) and Persistent Volume Claim (PVC)**:  
   Define a `persistent-volume.yaml` file for your storage configuration.  
   Apply the PV and PVC to Kubernetes:
   ```bash
   kubectl apply -f persistent-volume.yaml
   kubectl apply -f persistent-volume-claim.yaml
   ```

2. **Update the Deployment to Mount the Volume**:  
   Modify the `deployment.yaml` to mount the persistent volume.  
   Apply the updated deployment:
   ```bash
   kubectl apply -f deployment.yaml
   ```

---

### 5. Test Persistent Storage

1. **Store Data in the Volume**:  
   Access the application via the service and store some data.

2. **Delete the Pod and Check Data Retention**:  
   Delete one of the pods:
   ```bash
   kubectl delete pod <POD_NAME>
   ```

   Watch the pods being recreated:
   ```bash
   kubectl get pods -w
   ```

---

### 6. Scaling Tests

1. **Check Horizontal Pod Autoscaler (HPA)**:  
   Check the current HPA status:
   ```bash
   kubectl get hpa
   ```

2. **Trigger High CPU Usage**:  
   Run a load test using BusyBox to trigger high CPU usage:
   ```bash
   kubectl run --rm -it --image=busybox stress-test -- /bin/sh
   ```

3. **Verify Autoscaling**:  
   Inside the BusyBox shell, run the following command to generate load:
   ```bash
   while true; do wget -q -O- http://<SERVICE-IP>:<PORT>; done
   ```

4. **Verify the Number of Pods**:  
   Monitor the pods:
   ```bash
   kubectl get pods -w
   ```

---

### Conclusion

You have now set up a FastAPI-based Todo List application on Kubernetes with persistent storage and scaling capabilities. This setup can be extended with additional features like database integration and further autoscaling configurations.

This README covers everything from initial setup to advanced scaling tests and persistent storage. Let me know if you need more details!

---
