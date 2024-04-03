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


4) Create Security group for public instances
![Image Alt Text](screenshots/public_ec2_SG.png)

5) create public-instances
![Image Alt Text](screenshots/public-instances.png)

6) Create 3 private instances 
  a) server that has minikube and jenkins running on it
  b) dev server has node js
  c) server has mysql
Please note the selected instances are private instances
![Image Alt Text](screenshots/private-ec2.png)

7) ssh to Jenkins_server through bastion host and do the following
    a) install minikube && start it
    ![Image Alt Text](screenshots/start-minikube.png)
    b)check status of minikube and get nodes on cluster
    ![Image Alt Text](screenshots/minikube-status.png)
    c) create 3 namespaces (build,dev,test)
    ![Image Alt Text](screenshots/create-3-namespaces.png)
    d) list available namespaces on cluster
    ![Image Alt Text](screenshots/list-available-ns.png)
    


https://alex.dzyoba.com/blog/terraform-ansible/




