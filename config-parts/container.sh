#!/bin/vbash

# Container networks
set container network services prefix '10.5.0.0/24'

# cloudflare-ddns
set container name cloudflare-ddns allow-host-networks
set container name cloudflare-ddns environment CF_API_TOKEN value "${SECRET_CLOUDFLARE_DYNDNS_TOKEN}"
set container name cloudflare-ddns environment DOMAINS value 'ipv4.kokoro.wtf'
set container name cloudflare-ddns environment IP6_PROVIDER value "none"
set container name cloudflare-ddns environment TZ value ${TZ}
set container name cloudflare-ddns environment PGID value "1000"
set container name cloudflare-ddns environment PUID value "1000"
set container name cloudflare-ddns image 'docker.io/favonia/cloudflare-ddns:1.9.1'
set container name cloudflare-ddns memory '0'
set container name cloudflare-ddns restart 'on-failure'
set container name cloudflare-ddns shared-memory '0'

# coredns - main instance
set container name coredns cap-add 'net-bind-service'
set container name coredns image 'docker.io/coredns/coredns:1.10.1'
set container name coredns memory '0'
set container name coredns network services address '10.5.0.3'
set container name coredns restart 'on-failure'
set container name coredns shared-memory '0'
set container name coredns volume config destination '/config'
set container name coredns volume config source '/config/containers/coredns/config'
set container name coredns volume config mode 'ro'
set container name coredns volume corefile destination '/Corefile'
set container name coredns volume corefile source '/config/containers/coredns/config/Corefile'
set container name coredns volume corefile mode 'ro'
set container name coredns volume vyoshosts destination '/host/etc/hosts'
set container name coredns volume vyoshosts source '/etc/hosts'
set container name coredns volume vyoshosts mode 'ro'

# dnsdist
set container name dnsdist cap-add 'net-bind-service'
set container name dnsdist environment TZ value ${TZ}
set container name dnsdist image 'docker.io/powerdns/dnsdist-17:1.7.3'
set container name dnsdist memory '0'
set container name dnsdist network services address '10.5.0.4'
set container name dnsdist restart 'on-failure'
set container name dnsdist shared-memory '0'
set container name dnsdist volume config destination '/etc/dnsdist/dnsdist.conf'
set container name dnsdist volume config source '/config/containers/dnsdist/config/dnsdist.conf'
set container name dnsdist volume config mode 'ro'

# haproxy-k8s-api
set container name haproxy-k8s-api image 'docker.io/library/haproxy:2.7.6'
set container name haproxy-k8s-api memory '0'
set container name haproxy-k8s-api network services address '10.5.0.2'
set container name haproxy-k8s-api restart 'on-failure'
set container name haproxy-k8s-api shared-memory '0'
set container name haproxy-k8s-api volume config destination '/usr/local/etc/haproxy/haproxy.cfg'
set container name haproxy-k8s-api volume config source '/config/containers/haproxy/config/haproxy.cfg'
set container name haproxy-k8s-api volume config mode 'ro'

# node-exporter
set container name node-exporter environment procfs value '/host/proc'
set container name node-exporter environment rootfs value '/host/rootfs'
set container name node-exporter environment sysfs value '/host/sys'
set container name node-exporter image 'quay.io/prometheus/node-exporter:v1.5.0'
set container name node-exporter memory '0'
set container name node-exporter network services address '10.5.0.7'
set container name node-exporter restart 'on-failure'
set container name node-exporter shared-memory '0'
set container name node-exporter volume procfs destination '/host/proc'
set container name node-exporter volume procfs mode 'ro'
set container name node-exporter volume procfs source '/proc'
set container name node-exporter volume rootfs destination '/host/rootfs'
set container name node-exporter volume rootfs mode 'ro'
set container name node-exporter volume rootfs source '/'
set container name node-exporter volume sysfs destination '/host/sys'
set container name node-exporter volume sysfs mode 'ro'
set container name node-exporter volume sysfs source '/sys'

# speedtest-exporter
set container name speedtest-exporter image 'ghcr.io/miguelndecarvalho/speedtest-exporter:v3.5.3'
set container name speedtest-exporter memory '0'
set container name speedtest-exporter network services address '10.5.0.8'
set container name speedtest-exporter restart 'on-failure'
set container name speedtest-exporter shared-memory '0'

# unifi
set container name unifi environment RUNAS_UID0 value 'false'
set container name unifi environment TZ value ${TZ}
set container name unifi environment UNIFI_GID value '999'
set container name unifi environment UNIFI_STDOUT value 'true'
set container name unifi environment UNIFI_UID value '999'
set container name unifi image 'ghcr.io/jacobalberty/unifi-docker:v7.3.83'
set container name unifi memory '0'
set container name unifi network services address '10.5.0.10'
set container name unifi restart 'on-failure'
set container name unifi shared-memory '0'
set container name unifi volume data destination '/unifi'
set container name unifi volume data source '/config/containers/unifi'

# AdguardHome
set container name adguardhome image 'docker.io/adguard/adguardhome:v0.107.26'
set container name adguardhome memory '0'
set container name adguardhome network services address '10.5.0.5'
set container name adguardhome restart 'on-failure'
set container name adguardhome shared-memory '0'
set container name adguardhome volume data destination '/opt/adguardhome/work'
set container name adguardhome volume data source '/config/containers/adguardhome/data'
set container name adguardhome volume data destination '/opt/adguardhome/conf'
set container name adguardhome volume data source '/config/containers/adguardhome/conf'

set container name smtp-relay environment SMTP_DOMAIN value 'ctec.run'
set container name smtp-relay environment SMTP_PASSWORD value '${SMTP_PASS}'
set container name smtp-relay environment SMTP_PORT value '587'
set container name smtp-relay environment SMTP_SERVER value 'smtp.gmail.com'
set container name smtp-relay environment SMTP_USERNAME value 'devin@buhl.casa'
set container name smtp-relay image 'ghcr.io/foxcpp/maddy:0.6.3'
set container name smtp-relay memory '0'
set container name smtp-relay network services address '10.5.0.6'
set container name smtp-relay shared-memory '0'
set container name smtp-relay volume smtp-relay-config destination '/data/maddy.conf'
set container name smtp-relay volume smtp-relay-config mode 'ro'
set container name smtp-relay volume smtp-relay-config source '/config/containers/smtp-relay/config/maddy.conf'