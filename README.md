
## Demo
The demo output is too large for GitHub (800MB).  
You can download it here: https://drive.google.com/drive/folders/13AKwplriSsd-yeub4xBxtvtaWo5JVT_Z?dmr=1&ec=wgc-drive-hero-goto



Prerequisites

a. Install Ansible locally.
b. Install 2 VMs on AWS, Ubuntu via terraform main.tf
c. Create SSH key for SSH connection to VMs via terraform main.tf
d. Configure the AWS security group to allow inbound traffic on ports 22 and 8080 via terraform sg.tf

Deploy
a. Write public ip and sjsu_id of two VMs, ansible user and SSH private key file path to inventory.ini
b. Write deploy.yml playbook to install apache server, write welcom message in index.html, listen 8080 port and add vhost, etc
c. Run ansible-playbook to deploy.

After deployment, access the applications in the browser:

http://<VM1_IP>:8080

http://<VM2_IP>:8080
we should see the welcome message.

Undeploy
c. Run ansible-playbook to undeploy.
After undeployment, access the applications in the browser:

http://<VM1_IP>:8080

http://<VM2_IP>:8080
The site cann't be reached.