#!/bin/bash

cd /home/ec2-user/inegi-data-project

echo "Pulling latest code..."

git pull origin main

echo "Rebuilding containers..."

cd ./docker

docker-compose up -d --build

echo "Deployment done"