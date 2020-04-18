# BaSys 4.0 service platform - Docker Back-End

This repository contains a Docker-Compose file that setup (mostly 3rd party) back-end services and Web-based dashboards for the BaSys 4.0 service platform.

## Prerequisites

 1) Install [Docker](https://docs.docker.com/install/), e.g., in a [Ubuntu VM](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
    * If you [add your user to the docker group](https://docs.docker.com/install/linux/linux-postinstall/), you don't have to prefix your docker/docker-compose commands with sudo.
 2) Install [Docker-Compose](https://docs.docker.com/compose/install/)

## Installation

1) Clone this repo
2) Navigate into the subfolder 'runtime'
3) Inside the .env file, specify the `HOSTNAME` variable. This is used in the docker-compose.yml file for the following environment variables
   * `KAFKA_CFG_ADVERTISED_LISTENERS`
   * `MQTT_BROKER_IP`
   * `CAMUNDA_REST_URL`
4) Create the Docker stack

```bash
git clone https://github.com/BaSys-PC1/docker.git
cd docker/runtime
docker-compose pull && docker-compose up -d
```

## Usage

After installation, the following services are available.

| Service | Ports / URL |
| ------ | ------ |
| Portainer                   | http://[ip]:9090 |
| Apache Zookeeper            | 2181 | 
| Zoonavigator                | http://[ip]:9091 | 
| Apache Kafka                | 9092 | 
| Kafka HQ WebUI              | http://[ip]:9093 | 
| Apache Flink Jobmanger      | 6123 | 
| Apache Flink WebUI/REST     | http://[ip]:9094 | 
| Apache ActiveMQ             | 61616, 8161 | 
| MQTT Broker                 | 1883, 9001 | 
| Camunda BPM Platform        | http://[ip]:9080/camunda | 
| BaSys 4.0 Component Dashboard | http://[ip]:9081 |
| BaSys 4.0 Process Dashboard | http://[ip]:9082 |

## Downloads

A pre-installed Ubuntu Server 18.04.02 LTS VM can be downloaded
*  for [VMware](https://my.vmware.com/en/web/vmware/free#desktop_end_user_computing/vmware_workstation_player/15_0): https://cloud.dfki.de/owncloud/index.php/s/cTS7zyWTm7TFWfs
*  for [VirtualBox](https://www.virtualbox.org/wiki/Downloads): https://cloud.dfki.de/owncloud/index.php/s/SQr46mr4SsKS8Gs

The login is `basys / basys`.

The keyboard layout is set to German. Here, the keys for `y` and `z` are swapped, so pay attention when typing in `basys`. In order to change the keyboard layout, follow [this description](https://askubuntu.com/questions/342066/how-to-permanently-configure-keyboard).

If you use the VM for VirtualBox in NAT mode, you should configure port forwardings:

<img src='/docs/virtualbox-port-forwardings.png?raw=true' width='75%' height='75%'>

