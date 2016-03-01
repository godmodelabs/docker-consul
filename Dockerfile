FROM busybox:glibc
MAINTAINER it-operations@boerse-go.de
ENV TOOL=consul \
    VERSION=0.6.3 \
    SHA256=b0532c61fec4a4f6d130c893fd8954ec007a6ad93effbe283a39224ed237e250

ADD https://releases.hashicorp.com/${TOOL}/${VERSION}/${TOOL}_${VERSION}_linux_amd64.zip ${TOOL}_${VERSION}_linux_amd64.zip
RUN echo "${SHA256}  ${TOOL}_${VERSION}_linux_amd64.zip" | sha256sum -cw &&\
    unzip ${TOOL}_${VERSION}_linux_amd64.zip &&\
    rm -r ${TOOL}_${VERSION}_linux_amd64.zip

ENTRYPOINT ["/consul"]
