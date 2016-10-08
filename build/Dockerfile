FROM mono
MAINTAINER Aaron Roydhouse <aaron@roydhouse.com>

# Based on official mono with kubelet Kubernetes client added
# mono and sshd is needed for the Octopus Deploy Calamari utility
# kubectl is needed to deploy to a Kubernetes cluster
#
# When deployed into a Kubernetes cluster the Pod Service Account 
# is automatically available, and will work with kubectl without 
# further configuration. Or you can mount a kubctl config file 
# with certificates/tokens/password from a Kubernetes secret
#
# For ssh access you need to mount a suitable file at
# /root/.ssh/authorized_keys
# create-config.sh will create the ConfigMap for you, and
# the start.sh script will fix the .ssh directory permissions

ENV KUBE_LATEST_VERSION="v1.3.6"
RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update -y \
  && apt-get install -y ssh \
  && curl -sS -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kubectl \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && mkdir -p /var/run/sshd \
  && chmod 0755 /var/run/sshd

# We will start and expose ssh on port 22
EXPOSE 22

# Add the container start script, which will start ssh
COPY start.sh /
ENTRYPOINT ["/start.sh"]
