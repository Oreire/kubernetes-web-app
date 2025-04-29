## Deploying A Web Application on a Local Kubernetes Cluster

Organizations seek **efficient and cost-effective solutions** for deploying and managing their web applications.Leveraging **containerized applications** within a **Kubernetes environment** offers a practical and scalable approach to achieving this goal. In this project, **custom-made containers** are deployed on a **three-node Kubernetes cluster** running on **Docker Desktop**, specifically designed for **local development and testing**. This setup allows the simulation of production-like environments by Developers to streamline application management, and ensure **seamless testing** before deploying to **multi-node** or **cloud-based Kubernetes clusters**.

# The following steps are undertaken to implement this project:

1.	# Ensure Kubernetes is Enabled in Docker Desktop

    o	Open Docker Desktop → Navigate to Settings > Kubernetes → Enable Kubernetes using **Kind**
    o	Click Apply & Restart.
    o	Verify Kubernetes is running with: **kubectl version** and **kubectl get nodes**

2.	# Create a Dockerfile for Your Application
    A Dockerfile is used to package the web application with the NGINX web server. The Dockerfile copies the application files into NGINX’s default web root while also exposing port 80 to afford access for HTTP traffic.

3.	# Build and Push the Docker Image 

    o	As this was a local development and testing, the image was built using the local registry using the command: **docker build -t my-nginx-app .** The image name was retrieved from the Kubernetes portal on docker-desktop and used for the creation of the K8S manifest files for the deployment and the associated **NodePort service.**

4.	# Create Deployment YAML manifest and apply 

    o	Create Deployment manifest 
    o	Apply manifest: **kubectl apply -f deploymentt.yaml** 

5.	# Expose the Application Using a Service

    o	Create Service manifest nginx-svc.yaml
    o	Apply the service: **kubectl apply -f nginx-svc.yaml**

6.	# Access the Home Listing Web Application

    o	To access the web application, obtain exposed NodePorts using:  
        **kubectl get svc nginx-service** or 
        **kubectl describe svc nginx-service**

    o	The web application is accessible locally on the browser: **http://localhost:31693**

7.  # Project Deliverables

     o	**Deployment:** nginix-web

     o	**Service:** nginx-svc

     o	**Service Type:** NodePort  

     o	**Screenshots of Artifacts uploased as part of the repository** 
   
        
    
# Project Challenges

# Does Replica Count Ensure High Availability?

While deploying three replicas provides redundancy, it does not ensure high availability due to the **unpredictable rescheduling of pods in the event of failure.** Since node affinity and taints are not explicitly configured, pods may be scheduled on any available node, potentially compromising workload distribution. Additionally, **a failure of Docker Desktop itself would result in the complete unavailability of all nodes**, including replica pods. The Kubernetes cluster within Docker Desktop operates on a single-control plane architecture, which lacks fault tolerance if the master node crashes. Furthermore, the **absence of distributed node scheduling limits multi-node resilience**, as the setup is entirely dependent on a single machine. This introduces a single point of failure—if the local machine shuts down or crashes, the entire Kubernetes cluster goes offline, eliminating operational continuity. Finally, the **cluster lacks resource scalability**, as it is unable to distribute workloads across multiple nodes. This limitation reduces performance optimization and load balancing efficiency, potentially leading to bottlenecks and uneven resource utilization.

# Remedy: Achieve True High Availability?

Enhancing this project with a multi-node Kubernetes cluster will optimize replica distribution across nodes, improving fault tolerance and scalability. Implementing pod anti-affinity rules will ensure balanced scheduling, preventing workload concentration on a single node. Additionally, integrating a load balancer will facilitate efficient traffic distribution, enabling true high availability and minimizing the risk of downtime. 

This is achievable by making this web application accessible over the public internet for production environments is achievable through various approaches. One method is deploying a LoadBalancer service within a cloud-based Kubernetes environment, which provisions an external IP and efficiently manages incoming traffic. Another approach involves configuring Ingress with a custom domain, enabling advanced routing and secure HTTPS access while allowing for domain-based load balancing. Additionally, leveraging a cloud provider’s external IP service, such as AWS Elastic Load Balancer, Azure Application Gateway, or Google Cloud Load Balancer, ensures direct exposure to the internet with scalable traffic management capabilities.


# Best Practices

# Hence, for production-ready high availability, the following options are best practices:

    #  Kubernetes Services such as AWS EKS, Azure AKS, Google GKE.
	#  Multi-node Kubernetes on Bare Metal or Cloud Instances (Kubeadm, K3s).
	#  Distributed Control Plane & Workers across multiple physical nodes.
	#  Persistent Storage & Backup Strategies for data resilience.


# Next-Steps:

    #  Automation of Web Application Deployment Using Multi-node Kubernetes Cluster for High Avaialabiliy,   
       Scalability and Fault Tolerance.
