sudo dnf install -y git

ssh-keygen << EOF



EOF

cp /vagrant/confs/ssh/confid ~/.ssh/config
cat ~/.ssh/id_rsa.pub