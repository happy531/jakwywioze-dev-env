#!/bin/bash

# Droplet details
VM_USER="root"
VM_HOST="164.92.232.150"
VM_PORT="22"

# shellcheck disable=SC2164
cd ~/IdeaProjects

zip -r jakwywioze.zip jakwywioze-backend jakwywioze-dev-env jakwywioze-frontend

# Execute commands on the virtual machine using SSH key
scp -P $VM_PORT -r "jakwywioze.zip" $VM_USER@$VM_HOST:"jakwywioze"

rm -r jakwywioze.zip

ssh -p $VM_PORT $VM_USER@$VM_HOST << EOF
cd /root/jakwywioze/jakwywioze-dev-env && docker-compose -f docker-compose-prod.yml down
cd /root/jakwywioze
rm -r jakwywioze-backend && rm -r jakwywioze-dev-env && rm -r jakwywioze-frontend
unzip jakwywioze.zip
rm -r jakwywioze.zip
cd /root/jakwywioze/jakwywioze-dev-env && docker-compose -f docker-compose-prod.yml build --no-cache && docker-compose -f docker-compose-prod.yml up -d
exit

EOF
