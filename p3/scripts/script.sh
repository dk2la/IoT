echo "Setup Docker"
##install docker
curl -fsSL https://get.docker.com -o get-docker.sh
DRY_RUN=1 sh ./get-docker.sh
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
newgrp docker

echo "Install K3D"
## Install K3D
curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
sudo chmod +x /usr/local/bin/k3d

echo "Creating cluster"
## Create cluster
k3d cluster create aboba --api-port 6443 -p 8080:80@loadbalancer --agents 2

echo "Install kubectl"
##install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.22.0/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

echo "Get Info about new cluster"
## Get info abot cluster
kubectl cluster-info

echo "Create namespaces"
## Create namespaces
kubectl create namespace argocd
kubectl create namespace dev

echo "Applying K3D configs"
## Apply argocd Install conf
# kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -f /vagrant/configs/install.yaml -n argocd
kubectl apply -f /vagrant/configs/ingress.yaml -n argocd

echo "Set password for ArgoCD"
## Set password for ArgoCD newinceptionschoolproject newinceptionproject
kubectl -n argocd patch secret argocd-secret \
  -p '{"stringData": {
    "admin.password": "$2a$12$r1jYUHMDJdJoV5lYxfVQy.nUiTkU184OyB0rqZooDsSmYevLuSNdm",
    "admin.passwordMtime": "'$(date +%FT%T%Z)'"
  }}'

echo "Applying configs application for ArgoCD"
# ## Apply configuration
# kubectl apply -f /vagrant/confs/argocd-project.yaml -n argocd

# ## Setup application to argocd
# kubectl apply -f /vagrant/confs/application.yaml -n argocd
