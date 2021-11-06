echo "Install K3D"
## Install K3D
curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | sudo bash
sudo chmod +x /usr/local/bin/k3d
sudo mv /usr/local/bin/k3d /usr/bin

echo "Creating cluster"
## Create cluster
sudo k3d cluster create aboba --api-port 6443 -p 30000-30010:30000-30010@loadbalancer

echo "Install kubectl"
##install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.22.0/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/bin/kubectl

echo "Get Info about new cluster"
## Get info abot cluster
sudo kubectl cluster-info

echo "Create namespaces"
## Create namespaces
sudo kubectl create namespace argocd
sudo kubectl create namespace dev
sudo kubectl create namespace gitlab

echo "Applying K3D configs"
## Apply argocd Install conf
# kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
sudo kubectl apply -f ../confs/argocd/install.yaml -n argocd
sudo kubectl apply -f ../confs/argocd/ingress.yaml -n argocd

echo "Set password for ArgoCD"
## Set password for ArgoCD newinceptionschoolproject newinceptionproject
sudo kubectl -n argocd patch secret argocd-secret \
  -p '{"stringData": {
    "admin.password": "$2a$12$r1jYUHMDJdJoV5lYxfVQy.nUiTkU184OyB0rqZooDsSmYevLuSNdm",
    "admin.passwordMtime": "'$(date +%FT%T%Z)'"
  }}'

echo "Applying configs application for ArgoCD"
## Apply configuration
sudo kubectl apply -f ../confs/argocd/argocd-project.yaml -n argocd

## Setup application to argocd
sudo kubectl apply -f ../confs/argocd/application.yaml -n argocd

## Setup gitlab application
sudo kubectl apply -f ../confs/gitlab/deployment.yaml -n gitlab