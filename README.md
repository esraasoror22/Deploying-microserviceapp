# Deploying-microserviceapp

1) Login to AWS account && Create s3 buckend and enable versioning
![Image Alt Text](screenshots/s3-bucket.png)

2) Create Dynamo DB table with partition key LockID of type string
![Image Alt Text](screenshots/dynamodb-table.png)

3) Run terraform init to install provider plugins and initalize backend

![Image Alt Text](screenshots/initalize-modules.png)

3) write module for vpc ,import it on main.tf and apply

$ terraform init  
$terraform apply

Now statefile will be created ,stored on s3 and vpc will be created
![Image Alt Text](screenshots/statefile.png)

![Image Alt Text](screenshots/cluster-vpc.png)


https://alex.dzyoba.com/blog/terraform-ansible/



