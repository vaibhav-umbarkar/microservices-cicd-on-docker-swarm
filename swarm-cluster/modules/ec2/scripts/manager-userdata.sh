#!/bin/bash
set -e

TOKEN=$(curl -s -X PUT \
"http://169.254.169.254/latest/api/token" \
-H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

NODE_IP=$(curl -s \
-H "X-aws-ec2-metadata-token: $${TOKEN}" \
http://169.254.169.254/latest/meta-data/local-ipv4)

S3_PREFIX="s3://${swarm_discovery_bucket}/${swarm_name}"

LOCK_FILE="/tmp/bootstrap-lock"

echo "$${NODE_IP}" > "$${LOCK_FILE}"

# First check if swarm already exists
if aws s3 ls "$${S3_PREFIX}/manager_ip" >/dev/null 2>&1; then

  echo "Existing swarm found. Joining as manager..."

  aws s3 cp "$${S3_PREFIX}/manager_ip" /tmp/manager_ip
  aws s3 cp "$${S3_PREFIX}/manager_token" /tmp/manager_token
  
  EXISTING_MANAGER_IP=$(cat /tmp/manager_ip)
  MANAGER_TOKEN=$(cat /tmp/manager_token)
  
  docker swarm join \
    --token "$${MANAGER_TOKEN}" \
    "$${EXISTING_MANAGER_IP}:2377"
  
  exit 0
fi

echo "No swarm found. Trying to acquire bootstrap lock..."

# Try to become bootstrap manager
if aws s3 ls "$${S3_PREFIX}/bootstrap.lock" >/dev/null 2>&1; then

  echo "Another manager is bootstrapping. Waiting..."

  for i in {1..60}; do
    if aws s3 ls "$${S3_PREFIX}/manager_ip" >/dev/null 2>&1 &&
      aws s3 ls "$${S3_PREFIX}/manager_token" >/dev/null 2>&1; then

       echo "Swarm discovered. Joining..."
      
       aws s3 cp "$${S3_PREFIX}/manager_ip" /tmp/manager_ip
       aws s3 cp "$${S3_PREFIX}/manager_token" /tmp/manager_token
      
       EXISTING_MANAGER_IP=$(cat /tmp/manager_ip)
       MANAGER_TOKEN=$(cat /tmp/manager_token)
      
       docker swarm join \
         --token "$${MANAGER_TOKEN}" \
         "$${EXISTING_MANAGER_IP}:2377"
      
       exit 0
    fi
    sleep 10

  done

  echo "Timeout waiting for bootstrap manager"
  exit 1

else
  echo "Acquiring bootstrap lock..."

  aws s3 cp "$${LOCK_FILE}" \
    "$${S3_PREFIX}/bootstrap.lock"
  
  echo "Initializing first manager..."
  
  docker swarm init \
    --advertise-addr "$${NODE_IP}"
  
  WORKER_TOKEN=$(docker swarm join-token -q worker)
  MANAGER_TOKEN=$(docker swarm join-token -q manager)
  
  echo "$${NODE_IP}" > /tmp/manager_ip
  echo "$${WORKER_TOKEN}" > /tmp/worker_token
  echo "$${MANAGER_TOKEN}" > /tmp/manager_token
  
  aws s3 cp /tmp/manager_ip \
    "$${S3_PREFIX}/manager_ip"
  
  aws s3 cp /tmp/worker_token \
    "$${S3_PREFIX}/worker_token"
  
  aws s3 cp /tmp/manager_token \
    "$${S3_PREFIX}/manager_token"
fi
