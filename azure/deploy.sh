
#!/bin/bash

#Create resource group for AZ
az group create --location eastus --name CircleCI-RG

#Create AKS Cluster
az aks create -g CircleCI-RG \
    -n CircleCI-Cluster \
    --node-vm-size Standard_B2s\
    --nodepool-name ccipool \
    --node-count 1 \
    --generate-ssh-keys \
    --enable-node-public-ip

#Gets Kuberntes Cluster Credientials
az aks get-credentials --admin --name CircleCI-Cluster  --resource-group CircleCI-RG

az ad sp create-for-rbac --name circleci-deploy-account 


(⎈ |CircleCI-Cluster-admin:default)➜  .circleci git:(main) ✗ kubectl get pods
NAME                                   READY   STATUS    RESTARTS   AGE
ci-demo-application-5467fcb87d-z7dmn   1/1     Running   0          36s