
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


(⎈ |CircleCI-Cluster-admin:default)➜  .circleci git:(main) ✗ az ad sp create-for-rbac --name circleci-deploy-account
In a future release, this command will NOT create a 'Contributor' role assignment by default. If needed, use the --role argument to explicitly create a role assignment.
Creating 'Contributor' role assignment under scope '/subscriptions/[REDACTED]'
The output includes credentials that you must protect. Be sure that you do not include these credentials in your code or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli
'name' property in the output is deprecated and will be removed in the future. Use 'appId' instead.
{
  "appId": "[REDACTED]",
  "displayName": "circleci-deploy-account",
  "name": "[REDACTED]",
  "password": "[REDACTED]",
  "tenant": "[REDACTED]"
}

(⎈ |CircleCI-Cluster-admin:default)➜  .circleci git:(main) ✗ kubectl get pods
NAME                                   READY   STATUS    RESTARTS   AGE
ci-demo-application-5467fcb87d-z7dmn   1/1     Running   0          36s