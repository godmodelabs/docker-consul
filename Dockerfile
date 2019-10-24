FROM alpine:latest
LABEL maintainer="it-operations@boerse-go.de"
ENV TOOL=consul \
    VERSION=1.5.3 \
    SHA256=b402e1a0db26adb9638a9e85c6c672acd137df233e8c69f26180f2e2fd6f4cbc

# By using ADD there is no need to install wget or curl
ADD https://releases.hashicorp.com/${TOOL}/${VERSION}/${TOOL}_${VERSION}_linux_amd64.zip ${TOOL}_${VERSION}_linux_amd64.zip
RUN echo "${SHA256}  ${TOOL}_${VERSION}_linux_amd64.zip" | sha256sum -cw &&\
    unzip ${TOOL}_${VERSION}_linux_amd64.zip &&\
    rm -r ${TOOL}_${VERSION}_linux_amd64.zip

# additional software for health checks of services
RUN apk --no-cache add curl monitoring-plugins

ENTRYPOINT ["/consul"]
