FROM debian:buster

#Docker RUN example, pass in the git-lfs checkout copy you are working with
LABEL RUN="docker run -v git-lfs-checkout-dir:/src -v repo_dir:/repo"

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && \
apt-get install -y git dpkg-dev dh-golang ruby-ronn ronn curl

ARG GOLANG_VERSION=1.13.4
ARG GOLANG_SHA256=692d17071736f74be04a72a06dab9cac1cd759377bd85316e52b2227604c004c

ENV GOROOT=/usr/local/go

RUN cd /usr/local && \
    curl -L -O https://storage.googleapis.com/golang/go${GOLANG_VERSION}.linux-amd64.tar.gz && \
    [ "$(sha256sum go${GOLANG_VERSION}.linux-amd64.tar.gz | cut -d' ' -f1)" = "${GOLANG_SHA256}" ] && \
    tar zxf go${GOLANG_VERSION}.linux-amd64.tar.gz && \
    ln -s /usr/local/go/bin/go /usr/bin/go && \
    ln -s /usr/local/go/bin/gofmt /usr/bin/gofmt

COPY debian_script.bsh /tmp/

CMD /tmp/debian_script.bsh
