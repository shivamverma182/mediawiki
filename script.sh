#!/bin/bash
cd terraform
export DB_USER=$(terraform output -json|jq .db_user.value -r)
export DB_NAME=$(terraform output -json|jq .db_name.value -r)
export DB_PASSWD=$(terraform output -json|jq .db_password.value -r) 
export DB_HOST=$(terraform output -json|jq .db_host.value -r)
cd ..