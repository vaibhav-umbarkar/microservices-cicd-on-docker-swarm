#!/bin/bash
set -e

S3_PREFIX="s3://${swarm_discovery_bucket}/${swarm_name}"

# Wait until manager uploads discovery info
until aws s3 ls "$${S3_PREFIX}/manager_ip" >/dev/null 2>&1
do
    echo "Waiting for manager..."
    sleep 10
done

aws s3 cp "$${S3_PREFIX}/manager_ip" /tmp/manager_ip
aws s3 cp "$${S3_PREFIX}/worker_token" /tmp/worker_token

MANAGER_IP=$(cat /tmp/manager_ip)
WORKER_TOKEN=$(cat /tmp/worker_token)

docker swarm join \
    --token "$${WORKER_TOKEN}" \
    "$${MANAGER_IP}:2377"
    