FROM alpine:latest
MAINTAINER it-operations@boerse-go.de
ENV TOOL=consul \
    VERSION=1.0.1 \
    SHA256=eac5755a1d19e4b93f6ce30caaf7b3bd8add4557b143890b1c07f5614a667a68

# By using ADD there is no need to install wget or curl
ADD https://releases.hashicorp.com/${TOOL}/${VERSION}/${TOOL}_${VERSION}_linux_amd64.zip ${TOOL}_${VERSION}_linux_amd64.zip
RUN echo "${SHA256}  ${TOOL}_${VERSION}_linux_amd64.zip" | sha256sum -cw &&\
    unzip ${TOOL}_${VERSION}_linux_amd64.zip &&\
    rm -r ${TOOL}_${VERSION}_linux_amd64.zip

# additional software for health checks of services
RUN apk --no-cache add curl monitoring-plugins

ENTRYPOINT ["/consul"]
