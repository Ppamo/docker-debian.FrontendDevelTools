#!/bin/bash

node -e "console.log('==> Hello from Node.js ' + process.version)"
cd /opt/repos/project
npm install && npm start

