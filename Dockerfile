FROM alpine:latest
MAINTAINER it-operations@boerse-go.de
ENV TOOL=consul \
    VERSION=0.7.0 \
    SHA256=b350591af10d7d23514ebaa0565638539900cdb3aaa048f077217c4c46653dd8

# By using ADD there is no need to install wget or curl
ADD https://releases.hashicorp.com/${TOOL}/${VERSION}/${TOOL}_${VERSION}_linux_amd64.zip ${TOOL}_${VERSION}_linux_amd64.zip
RUN echo "${SHA256}  ${TOOL}_${VERSION}_linux_amd64.zip" | sha256sum -cw &&\
    unzip ${TOOL}_${VERSION}_linux_amd64.zip &&\
    rm -r ${TOOL}_${VERSION}_linux_amd64.zip

# additional software for health checks of services
RUN apk --no-cache add curl

ENTRYPOINT ["/consul"]
