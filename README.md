# BaSys 4.0 Service Platform - Docker Runtime and Demonstration Environment

This repository contains two Docker-Compose stacks that setup 
 * 3rd-party back-end services and 
 * Basys-related containers for Administration Shell Management, Web-based dashboards, Control Components, and the BaSys service platform.

## Prerequisites

 1) Install [Docker](https://docs.docker.com/install/), 
    * e.g., in a [Ubuntu VM](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
      * If you [add your user to the docker group](https://docs.docker.com/install/linux/linux-postinstall/), you don't have to prefix your docker/docker-compose commands with sudo.
	* or in [Windows using WSL2 and Docker Desktop](https://nickjanetakis.com/blog/a-linux-dev-environment-on-windows-with-wsl-2-docker-desktop-and-more)
 2) Install [Docker-Compose](https://docs.docker.com/compose/install/)
    * Docker-Compose is already available in Docker Desktop.

## Installation

1) Clone this repo
2) Navigate into the subfolders 'backend' and 'demonstrator'.
3) Inside the .env file, specify the `HOSTNAME` variable, the default is set to '127.0.0.1'. So, for local installations nothing needs to be changed.
   * In the backend stack, this is required for dealing with the Apache Kafka-specific concept of advertised listeners in combination with docker. 
   * The same concept is applied in the demonstrator stack for rewriting URL endpoints of administration shells and hosted submodels.
4) Create the Docker stack
5) Immediately stop the containers 'service-platform' and cc-server'. For demonstration purposes, they should be started manually whenever needed in the order 'cc-server' -> 'service-platform'. For this reason, these containers do not specify a 'restart: always' policy.

```bash
git clone https://github.com/BaSys-PC1/docker.git
cd docker/backend
docker-compose pull && docker-compose up -d
cd ../demonstrator
docker-compose pull && docker-compose up -d
docker-compose stop service-platform
docker-compose stop cc-server
```

## Usage

After installation, the following services are available from the backend stack.

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

The demonstator stack exposes the following services.

| Service | Ports / URL |
| ------ | ------ |
| BaSys Component Dashboard   | http://[ip]:9081 |
| BaSys Process Dashboard     | http://[ip]:9082 |
| BaSys AAS Registry          | http://[ip]:4999 |
| BaSys AAS Aggregator Service| http://[ip]:5080 |
| BaSys AAS Hosting Service (in aas-services)   | http://[ip]:5081 |
| BaSys AAS Hosting Service (in cc-server)   | http://[ip]:5082 |
| BaSys AAS Hosting Service (in service-platform)   | http://[ip]:5083 |

## Configuration

coming soon

## Downloads

A pre-installed Ubuntu Server 20.04.01 LTS VM can be downloaded
*  for [VMware](https://download3.vmware.com/software/player/file/VMware-player-16.0.0-16894299.exe): https://cloud.dfki.de/owncloud/index.php/s/cTS7zyWTm7TFWfs
*  for [VirtualBox](https://www.virtualbox.org/wiki/Downloads): https://cloud.dfki.de/owncloud/index.php/s/SQr46mr4SsKS8Gs

The login is `basys / basys`.

The keyboard layout is set to German. Here, the keys for `y` and `z` are swapped, so pay attention when typing in `basys`. In order to change the keyboard layout, follow [this description](https://askubuntu.com/questions/342066/how-to-permanently-configure-keyboard).

If you use the VM for VirtualBox in NAT mode, you should configure port forwardings according to the table above:

<img src='/docs/virtualbox-port-forwardings.png?raw=true' width='75%' height='75%'>

