FROM node:12-alpine3.12

RUN apk update && apk add --no-cache docker curl shadow sudo make gcc g++ python3 tar
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
  && chmod u+x ./kubectl \
  && mv kubectl /usr/local/bin \
  && curl -LO https://github.com/digitalocean/doctl/releases/download/v1.16.0/doctl-1.16.0-linux-amd64.tar.gz \
  && tar xzvf doctl-1.16.0-linux-amd64.tar.gz \
  && chmod u+x ./doctl \
  && mv doctl /usr/local/bin

RUN \
  adduser -D -G docker docker && \
  adduser -D runner && \
  echo "runner ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/runner && \
  chmod 0440 /etc/sudoers.d/runner

USER runner
CMD /bin/sh