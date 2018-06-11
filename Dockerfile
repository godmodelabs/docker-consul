FROM alpine:latest
MAINTAINER it-operations@boerse-go.de
ENV TOOL=consul \
    VERSION=1.1.0 \
    SHA256=09c40c8b5be868003810064916d8460bff334ccfb59a5046390224b27e052c45

# By using ADD there is no need to install wget or curl
ADD https://releases.hashicorp.com/${TOOL}/${VERSION}/${TOOL}_${VERSION}_linux_amd64.zip ${TOOL}_${VERSION}_linux_amd64.zip
RUN echo "${SHA256}  ${TOOL}_${VERSION}_linux_amd64.zip" | sha256sum -cw &&\
    unzip ${TOOL}_${VERSION}_linux_amd64.zip &&\
    rm -r ${TOOL}_${VERSION}_linux_amd64.zip

# additional software for health checks of services
RUN apk --no-cache add curl monitoring-plugins

ENTRYPOINT ["/consul"]
