FROM alpine:latest
LABEL maintainer="it-operations@boerse-go.de"
ENV TOOL=consul \
    VERSION=1.6.5 \
    SHA256=520dfb3a099a1e3832bcf25abb328e9e218a7b2f865c709f07f0ac09b953026e

# By using ADD there is no need to install wget or curl
ADD https://releases.hashicorp.com/${TOOL}/${VERSION}/${TOOL}_${VERSION}_linux_amd64.zip ${TOOL}_${VERSION}_linux_amd64.zip
RUN echo "${SHA256}  ${TOOL}_${VERSION}_linux_amd64.zip" | sha256sum -cw &&\
    unzip ${TOOL}_${VERSION}_linux_amd64.zip &&\
    rm -r ${TOOL}_${VERSION}_linux_amd64.zip

# additional software for health checks of services
RUN apk --no-cache add curl monitoring-plugins

ENTRYPOINT ["/consul"]
