FROM mono
MAINTAINER Aaron Roydhouse <aaron@roydhouse.com>

# Based on official mono with kubectl Kubernetes client added
# mono and sshd is needed for the Octopus Deploy Calamari utility
# kubectl, helm, and cli53 are used to deploy to a Kubernetes cluster
# gettext-base package is added for envsubt utility
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

ENV \
  KUBE_VERSION="v1.5.2" \
  HELM_VERSION="v2.3.1" \
  CLI53_VERSION="0.8.8"

RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update -y \
  && apt-get install -y ssh gettext-base \
  && curl -sS -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
  && curl -sS -L https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz | tar xzf - -C /usr/local/bin --strip-components=1 linux-amd64/helm \
  && curl -sS -L https://github.com/barnybug/cli53/releases/download/${CLI53_VERSION}/cli53-linux-amd64 -o /usr/local/bin/cli53 \
  && chmod +x /usr/local/bin/kubectl /usr/local/bin/cli53 \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && mkdir -p /var/run/sshd \
  && chmod 0755 /var/run/sshd

# We will start and expose ssh on port 22
EXPOSE 22

# Add the container start script, which will start ssh
COPY start.sh /
ENTRYPOINT ["/start.sh"]
