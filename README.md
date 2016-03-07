# docker-consul
A busybox:glibc based Docker container running HashiCorp's consul on CoreOS instances.

## From cloud-config
```
#cloud-config

coreos:
  units:
    - name: consul.service
      command: start
      content: |
        [Unit]
        Description=HashiCorp consul service
        Documentation=https://www.consul.io/docs/index.html
        [Service]
        Restart=always
        ExecStart=/usr/bin/docker run --rm --name consul \ 
          -v /var/local/consul:/var/local/consul \
          -v /etc/consul:/etc/consul:ro \
          -v /etc/ssl/certs:/etc/ssl/certs:ro \
          -v /usr/share/ca-certificates:/usr/share/ca-certificates:ro \
          --net=host \
          godmodelabs/consul agent -config-dir=/etc/consul
        ExecStop=-/usr/bin/docker stop consul
```
