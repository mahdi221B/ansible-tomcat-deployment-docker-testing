#!/bin/bash

echo ""
echo "# Step 1: Build the test image"
echo "---------------------------"
docker build -t tomcat-test-container .
echo ""

echo ""
echo "# Step 2: Build the Docker container"
echo "---------------------------"
docker run --privileged=true -v $(pwd)/deploy:/data tomcat_test_container
echo ""

echo ""
echo "# Step 3: Execute the tomcat_test.sh script inside the container"
echo "---------------------------"
docker exec $(docker ps -q -l) bash -c "/data/tomcat_test.sh DEV"
echo ""