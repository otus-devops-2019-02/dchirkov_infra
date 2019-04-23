#!/bin/bash
echo '--- Install packages ---'
wget -O /tmp/packer.zip https://releases.hashicorp.com/packer/1.4.0/packer_1.4.0_linux_amd64.zip
sudo unzip -o -d /usr/local/bin/ /tmp/packer.zip
wget -O /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip
sudo unzip -o -d /usr/local/bin/ /tmp/terraform.zip
wget -O /tmp/tflint.zip https://github.com/wata727/tflint/releases/download/v0.7.5/tflint_linux_amd64.zip
sudo unzip -o -d /usr/local/bin/ /tmp/tflint.zip
pip install ansible-lint

echo '--- Check packer ---'
packer validate -var-file=packer/variables.json.example packer/app.json
packer validate -var-file=packer/variables.json.example packer/db.json

echo '--- Check terraform ---'
terraform init terraform/stage/
terraform init terraform/prod/
terraform validate -var-file=terraform/stage/terraform.tfvars.example terraform/stage/
terraform validate -var-file=terraform/stage/terraform.tfvars.example terraform/prod/

echo '--- Check tflint ---'
cd terraform/prod/
tflint
cd ../stage/
tflint
cd ..

echo '--- Check ansible-lint ---'
ansible-lint --exclude=ansible/roles/jdauphant.nginx ansible/playbooks/site.yml
