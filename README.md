# Automated Deployment of Tomcat with Ansible and Docker

The purpose of this test is to automate the deployment of Tomcat using Ansible and test the deployment within a Docker container.

1. Resource Preparation:
   - Place the following files in the “deploy” directory:
     - `tomcat_deploy.yml`: An Ansible playbook that installs Tomcat and deploys the WAR file.
     - `tomcat_deploy.sh`: A script that tests the Ansible configuration in a Docker container.
     - `sample.war`: The WAR file to be deployed.
     - `tomcat_test.sh`: A script used to test the deployed Tomcat server.

2. Production of the Ansible Playbook `tomcat_deploy.yml`:
   - The playbook should include the following tasks:
     - Since the tests will be performed locally, the remote machine is the same as the control machine. Use “localhost” as the remote machine. In this case, Ansible will execute the tasks directly on the local machine without establishing an SSH connection. Therefore, I will use “localhost” in my `tomcat_deploy.yml` file.
     - Installation of Tomcat version 9: Use the `apt` module, which is a package manager module. It allows Ansible to install, update, or remove packages on the target hosts.
     - Configuration of the maximum JVM heap size based on the environment (DEV or PROD).
     - Deployment of the `sample.war` file: Use the `copy` module to copy the `sample.war` file to the Tomcat's webapps directory.
     - Configuration of the maximum JVM heap size based on the environment (DEV or PROD): Use the `lineinfile` module to manage Tomcat configurations such as JVM and others. It will search for lines matching a specific pattern using regular expressions and then modify that line in the Tomcat configuration file.
     - Deployment of the WAR file `sample.war`.

3. Production of the script `tomcat_deploy.sh`:
   - The script allows testing the Ansible configuration in a Docker container. Modify it to include the following actions:
     - Build a Docker container using the provided Dockerfile.
     - Launch the container with the `--privileged=true` option to avoid startup issues.
     - Mount the `deploy` directory as `/data` inside the Docker container.
     - Execute the `tomcat_test.sh` script inside the container: Use the command `docker ps -q -l` to dynamically obtain the ID of the last created container on each script execution, simplifying the process.
     - Now, running `tomcat_deploy.sh` will test the Ansible configuration in a Docker container, which will automatically execute the `tomcat_test.sh` script. The script will check:
       - The running Java process and its parameters.
       - The state of the Tomcat service.

**Note:**
- Make sure to follow the instructions mentioned in the initial README file for mounting the `deploy` directory and passing the environment parameter to the Ansible command.
- Please submit your solution as a zip repository, including relevant explanations.
