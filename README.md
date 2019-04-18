# BaSys 4.0 service platform - Docker Back-End

This repository contains a Docker-Compose file that setup (mostly 3rd party) back-end services and Web-based dashboards for the BaSys 4.0 service platform.

## Prerequisites

 1) Install [Docker](https://docs.docker.com/install/), e.g., in a [Ubuntu VM](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
    * If you [add your user to the docker group](https://docs.docker.com/install/linux/linux-postinstall/), you don't have to prefix your docker/docker-compose commands with sudo.
 2) Install [Docker-Compose](https://docs.docker.com/compose/install/)

## Installation

1) Clone this repo
2) Navigate into the subfolder 'runtime'
3) Create the Docker stack

```bash
git clone https://github.com/BaSys-PC1/docker.git
cd docker/runtime
docker-compose up -d
```

## Usage

After installation, the following services are available.

| Service | Ports / URL |
| ------ | ------ |
| Portainer                   | http://[ip]:9090 |
| Apache Zookeeper            | 2181 | 
| Zoonavigator                | http://[ip]:9091 | 
| Apache Kafka                | 9092 | 
| Apache ActiveMQ             | 61616, 8161 | 
| MQTT Broker                 | 1883, 9001 | 
| Camunda BPM Platform        | http://[ip]:9080/camunda | 
| BaSys 4.0 Process Dashboard | http://[ip]:9082 |

