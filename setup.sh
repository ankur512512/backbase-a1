#!/bin/bash

echo "Log in to docker...\n\n"
docker login -u backbasedevops -p backbase@123

echo "Building and tagging Docker images\n\n"
docker build -f Dockerfile-tomcat . -t backbasedevops/tomcat
docker build -f Dockerfile-nginx . -t backbasedevops/nginx

echo "Pushing docker images to repo\n\n"
docker push backbasedevops/nginx
docker push backbasedevops/tomcat

echo "Installing k8s deployments\n\n"
kubectl apply -f .

echo "Waiting for 10 seconds for all the pods to come online...Stay with us\n\n"

sleep 10

kubectl get pods


echo "\n\n Everything is ready please test using the Steps listed in the document."
