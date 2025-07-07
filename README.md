# Author: Daoud Hussain

## 🧠 CambioML Cloud Infra Challenge – Micro VM with VNC on GKE

This project demonstrates a lightweight Linux desktop running in a container, exposed via VNC in a web browser, and orchestrated with Kubernetes on **Google Kubernetes Engine (GKE)** using **Terraform** for infrastructure provisioning.

---

## 📁 Project Structure

```
k8s-task/
├── terraform/ 
│ ├── main.tf
│ ├── variables.tf
│ └── provider.tf
├── k8s-manifests/
│ ├── deployment.yml
│ └── service.yml
├── Dockerfile 
└── README.md 
```

## ✅ Prerequisites

Install the following tools:

```bash
sudo apt update
sudo snap install docker
sudo snap install kubectl --classic
sudo snap install google-cloud-cli --classic
Authenticate Google Cloud:


gcloud auth login
gcloud auth application-default login
gcloud config set project <your-gcp-project-id>
Enable required APIs:


gcloud services enable container.googleapis.com
gcloud services enable compute.googleapis.com

```
## ⚙️ Step-by-Step Setup

### 1️⃣ Provision Infrastructure with Terraform
Navigate to the Terraform directory:
```
cd terraform/
terraform init
terraform apply
```

This will: 
- Create a GKE cluster
- Configure networking

### 2️⃣ Connect kubectl to GKE
After successful apply, run:

```
gcloud container clusters get-credentials cambioml-cluster --region=us-central1
```
### 3️⃣ Build and Push Docker Image
1. Authenticate Docker to GCR:

```
gcloud auth configure-docker
```
2. Build and push your container:

```
docker build -t gcr.io/cambioml-vnc-microvm/vnc-microvm:latest .
docker push gcr.io/cambioml-vnc-microvm/vnc-microvm:latest
```

3. Update your image in deployment.yml accordingly.

### 4️⃣ Deploy to Kubernetes

Apply your deployment and service:

```
kubectl apply -f ../k8s-manifests/deployment.yml
kubectl apply -f ../k8s-manifests/service.yml
```

### 5️⃣ Access the VNC Desktop
Fetch the external IP:

```
kubectl get svc
```
Open in your browser:

http://34.61.66.163

![terminal](https://github.com/user-attachments/assets/7e2a5318-0eb6-4bcb-9dc0-ad8c6ca42312)


This will load a Linux desktop environment via noVNC in your browser.

## 🛠️ Components Overview

### Dockerfile: 
Based on dorowu/ubuntu-desktop-lxde-vnc, with LXDE and VNC access on port 6080.

### Terraform: 
Sets up the GKE cluster and networking.

### Kubernetes:

- deployment.yml: Deploys the containerized desktop.

- service.yml: Exposes the pod using a LoadBalancer.

- noVNC: Web-based VNC client for browser access.

## 🚀 Performance

- Boot time: < 15 seconds (cold start)

- Lightweight LXDE ensures minimal image size

- Stateless setup; easy to scale horizontally


## 💡 Future Improvements

- Enable autoscaling based on usage

- Integrate ephemeral storage per pod

- Secure VNC with authentication

- Add metrics collection with Prometheus/Grafana

## 🙌 Thanks!

This was built for the CambioML Founding Cloud Infra Engineer Challenge. Let me know if you'd like to collaborate further or want to improve this system with GPU-enabled desktops or ephemeral runners.
