# docker-consul
A busybox:glibc based Docker container running HashiCorp's nomad on CoreOS instances.

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
        ExecStart=/usr/bin/docker run --rm --net=host --name consul godmodelabs/consul agent -server -config-dir=/etc/consul
        ExecStop=-/usr/bin/docker stop consul
```
