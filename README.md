# docker-debian.FrontendDevelTools

Debian based Dockerfile to run Frontend development tools
For now it compiles and install different versions of node:

**Usage:** 
*./setup.sh VERSION NUMBER*

**i.e:**
*./setup.sh 6*

This compiles and install node, from code setting branch **v6.x**.
The code should be already in the machine to be passed to the container as a volume.
The default location is the 'code' folder in this repository.
