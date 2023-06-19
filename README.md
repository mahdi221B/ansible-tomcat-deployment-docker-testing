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
     - Installation of Tomcat version 9: Use the `apt` module, which is a package manager module. It allows Ansible to install, update, or remove packages on the target hosts.
     - Deployment of the `sample.war` file: Use the `copy` module to copy the `sample.war` file to the Tomcat's webapps directory.
     - Configuration of the maximum JVM heap size based on the environment (DEV or PROD): Use the `lineinfile` module to manage Tomcat configurations such as JVM and others. It will search for lines matching a specific pattern using regular expressions and then modify that line in the Tomcat configuration file.

3. Production of the script `tomcat_deploy.sh`:
   - The script allows testing the Ansible configuration in a Docker container. Modify it to include the following actions:
     - Build a Docker container using the provided Dockerfile.
     - Launch the container with the `--privileged=true` option to avoid startup issues.
     - Mount the `deploy` directory as `/data` inside the Docker container.
     - Execute the `tomcat_test.sh` script inside the container: Use the command `docker ps -q -l` to dynamically obtain the ID of the last created container on each script execution.
     - Running `tomcat_test.sh`, which will automatically check:
       - The running Java process and its parameters.
       - The state of the Tomcat service.