FROM ansi/rpi-golang:1.5
MAINTAINER syou6162@gmail.com

ENV GO15VENDOREXPERIMENT=1

WORKDIR $GOPATH
RUN mkdir -p ./src/github.com/Masterminds
WORKDIR $GOPATH/src/github.com/Masterminds
RUN git clone https://github.com/Masterminds/glide
WORKDIR glide
RUN make install
RUN mkdir -p $GOPATH/src/github.com/coreos

WORKDIR $GOPATH/src/github.com/coreos
ADD . ./aws-auth-proxy
WORKDIR ./aws-auth-proxy
RUN glide install
RUN go install github.com/coreos/aws-auth-proxy

ENTRYPOINT ["aws-auth-proxy"]