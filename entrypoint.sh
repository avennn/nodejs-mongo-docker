#!/usr/bin/bash

mongod --config /etc/mongod.conf --fork
cd /opt/projects/miniapp-deployer/deploy-server
yarn start