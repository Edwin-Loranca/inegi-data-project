#!/bin/bash

cd /home/ec2-user/inegi-data-project

echo "Pulling latest code..."
git pull origin master

echo "Rebuilding containers..."
cd ./infra/docker

docker-compose up -d --build

echo "Deployment done"