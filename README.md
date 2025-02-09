# bruxy
[![Publish Docker image as latest](https://github.com/reon04/bruxy/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/reon04/bruxy/actions/workflows/docker-publish.yml)

bruxy, the BRU proxy. A docker image that proxies the Ruhr University Bochum (RUB) website and performs string replacements in the response.


## Releases and Deployment

Get the latest release from [Docker Hub](https://hub.docker.com/r/reon04/bruxy).


### Envirionment Variables

| Env | Default | Description |
| --- | --- | --- |
| SHORT_DOMAIN | rub.de | short domain under which the bruxy will be reachable (e.g. bru.fyi) |
| LONG_DOMAIN | ruhr-uni-bochum.de | long domain under which the bruxy will be reachable (e.g. bochum-ruhr-uni.de) |
| DNS_RESOLVER | 1.1.1.1 | optional IP address of a local DNS resolver, by default a Cloudflare DNS server will be used


## LICENSE

This repository is licensed under [MIT](LICENSE).