# Steps to deploy mediawiki

## Build the image
Navigate to the dockter image build and run following command
    
    docker image build . -t repo:mediawiki:v1

`NOTE: There is no package for http2 module for apache in redhat scl repo so are disabling the module.`

## Create Azure Database for mysql
1. Navigate to the terraform directory
2. Add egress public ip of kubernetes to terraform.auto.tfvars
3. Run terraform apply
4. Once apply is successful run below command
    
    `export DB_PASSWD=$(terraform output -json|jq .db_password.value -r)`

    `export DB_HOST=$(terraform output -json|jq .db_host.value -r)`

    `export DB_USER=$(terraform output -json|jq .db_user.value -r)`

    `export DB_NAME=$(terraform output -json|jq .db_name.value -r)`
5. Next we need to create schema for mediawiki

    `mysql $DB_NAME --host $DB_HOST --user $DB_USER -p$DB_PASSWD < mediawiki/schema.sql`

## Deploy mediawiki on kubernetes
1. Run below command to deploy application
    
    `helm install mediawiki . --set database.type=mysql --set database.host=$(DB_HOST) --set database.name=$(DB_NAME) --set database.user=$(DB_USER) --set database.password=$(DB_PASSWD) --namespace mediawiki --create-namespace`

`Note: The site takes sometime to load due to slow connection to mysql database`

# Images
[mediawiki](/images/image1.png)
[database](/images/image2.png)
