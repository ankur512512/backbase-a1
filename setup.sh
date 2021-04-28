#!/bin/bash

echo -e "\n\nLog in to docker...\n\n"
docker login -u backbasedevops -p backbase@123

echo -e "\n\nBuilding and tagging Docker images\n\n"
docker build -f Dockerfile-tomcat . -t backbasedevops/tomcat
docker build -f Dockerfile-nginx . -t backbasedevops/nginx

echo -e "\n\nPushing docker images to repo\n\n"
docker push backbasedevops/nginx
docker push backbasedevops/tomcat

echo -e "\n\nInstalling k8s deployments\n\n"
kubectl apply -f .

echo -e "\n\nWaiting for 10 seconds for all the pods to come online...Stay with us\n\n"

sleep 10

kubectl get pods


echo -e "\n\n Everything is ready please test using the Steps listed in the document."
