#!/bin/bash

cd /home/ec2-user/dagster-project

echo "Pulling latest code..."

git pull origin main

echo "Rebuilding containers..."

docker-compose up -d --build

echo "Deployment done"