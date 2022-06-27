# /bin/bash

env="dev"

arm_client_id_var=""
arm_client_secret_var=""
arm_sub_id_var=""
arm_tenant_id_var=""

git clone https://github.com/kharbandaashish/deloitte-case-func-tf.git

cd deloitte-case-func-tf

export ARM_CLIENT_ID=$arm_client_id_var
export ARM_CLIENT_SECRET=$arm_client_secret_var
export ARM_SUBSCRIPTION_ID=$arm_sub_id_var
export ARM_TENANT_ID=$arm_tenant_id_var

terraform init -input=false -backend=true -backend-config="$env/backend.tfvars"

terraform plan -var-file="$env/terraform.tfvars" -out=plan.out -detailed-exitcode

terraform apply -input=false -auto-approve=true plan.out

curl https://deloitte-case-func-001.azurewebsites.net/api/deloitte-case-func-app-001?input_string=Hi%20Deloitte%20Oracle%20Gartner
