#/bin/bash

cd "$(dirname $0)/terraform"

terraform init
terraform apply