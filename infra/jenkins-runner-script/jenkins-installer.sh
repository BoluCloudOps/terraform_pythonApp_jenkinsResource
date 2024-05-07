#!/bin/bash
sudo apt-get update
yes | sudo apt install openjdk-11-jdk-headless
echo "Waiting for 30 seconds before installing the jenkins package..."
sleep 30
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
yes | sudo apt-get install jenkins
sleep 30
#Install Terraform
echo "Waiting for 30 seconds before installing the Terraform..."
wget https://releases.hashicorp.com/terraform/1.6.5/terraform_1.6.5_linux_386.zip
yes | sudo apt-get install unzip
unzip 'terraform*.zip'
sudo mv terraform /usr/local/bin/
sleep 30
#Install Hashicorp Vault
sudo apt update && sudo apt install gpg
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt install vault


# vault policy write terraform - <<EOF
# path "*" {
#   capabilities = ["list", "read"]
# }

# path "secrets/data/*" {
#   capabilities = ["create", "read", "update", "delete", "list"]
# }

# path "kv/data/*" {
#   capabilities = ["create", "read", "update", "delete", "list"]
# }


# path "secret/data/*" {
#   capabilities = ["create", "read", "update", "delete", "list"]
# }

# path "auth/token/create" {
# capabilities = ["create", "read", "update", "list"]
# }
# EOF
#for expiry keys or tokens
# vault write http://18.153.93.76:8200/auth/approle/role/terraform \
#     secret_id_ttl=10m \
#     token_num_uses=10 \
#     token_ttl=20m \
#     token_max_ttl=30m \
#     secret_id_num_uses=40 \
#     token_policies=terraform
# vault write auth/approle/role/terraform \
#     secret_id_ttl=10m \
#     token_num_uses=10 \
#     token_ttl=20m \
#     token_max_ttl=30m \
#     secret_id_num_uses=40 \
#     token_policies=terraform

# vault write auth/approle/role/terraform-role \
#     token_num_uses=10 \
#     secret_id_num_uses=10m \
#     token_ttl=20m \
#     token_max_ttl=30m \
#     period="0s" \
#     policies="terraform-policy"

# Worked https://medium.com/@niteshsapkota10/hashicorp-vault-integration-with-jenkins-example-with-terraform-fc1e179c9384
    # vault write auth/approle/role/terraform-role \
    # token_num_uses=0 \
    # secret_id_num_uses=0 \
    # period="0s" \
    # policies="terraform-policy"