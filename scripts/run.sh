#!/bin/bash

# if node is available then there is not need to build it again
if ! which node > /dev/null 2>&1; then
	cd /opt/nodejs
	git checkout $NODE_BRANCH
	make clean
	./configure
	VERSION=$(echo $NODE_BRANCH | grep -o -e '^v[0-9]')
	VERSION=${VERSION:1}
	if [ $VERSION -ge 6 ]; then
		make -j4 && make install
	else
		make && make install
	fi
fi
node -e "console.log('==> Hello from Node.js ' + process.version)"
/bin/bash
