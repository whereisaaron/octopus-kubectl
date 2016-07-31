FROM mono
MAINTAINER Aaron Roydhouse <aaron@roydhouse.com>

# Based on official mono with kubelet Kubernetes client added
# mono and sshd is needed for the Octopus Deploy Calamari utility
# kubectl is needed to deploy to a Kubernetes cluster
# kubctl config file with certificates/tokens/password should be 
# mounts from a Kubernetes secret

ENV KUBE_LATEST_VERSION="v1.3.3"
RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update -y \
  && apt-get install -y ssh \
  && curl -sS -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kubectl \
  && useradd --create-home octopus --shell /bin/bash \
  && mkdir ~octopus/.ssh \
  && chown octopus:octopus ~octopus/.ssh \
  && chmod 700 ~octopus/.ssh \
  && apt-get autoremove -y \
  && apt-get clean -y

# We will start and expose ssh on port 22
EXPOSE 22

# Add the container start script, which will start ssh
COPY start.sh /
ENTRYPOINT ["/start.sh"]
