#!/bin/bash

cd "$(dirname $0)"

ssh -o "StrictHostKeyChecking=no" -i ${ansible_ssh_private_key_file} ${ansible_user}@${ansible_host}