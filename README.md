## Kubernetes 'pivot machine' Docker image for Octopus Deploy

Docker container with mono, sshd, kubectl, helm, cli53, duplicacy, git for automated Kubernetes deployments with Octopus Deploy.
Can be used an 'ssh' deployment machine for Octopus Deploy, to install and run the Calamari agent.

Automated build images available from Docker hub
https://hub.docker.com/r/whereisaaron/octopus-kubectl/

In order to avoid Octopus no longer recognising the ssh target after each restart, this image includes a fixed set of
ssh host keys. You should ideally use your own host keys for your deployment. Generate your own host keys and build your 
own container image (see build/Build.sh) or map in your own host keys into /etc/ssh with docker/kubernetes when you deploy.
