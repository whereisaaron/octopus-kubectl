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
  && apt-get autoremove -y \
  && apt-get clean -y \
  && mkdir -p /var/run/sshd \
  && chmod 0755 /var/run/sshd

# We will start and expose ssh on port 22
EXPOSE 22

# Run sshd as the main process
ENTRYPOINT ["/usr/sbin/sshd", "-D", "-q"]
