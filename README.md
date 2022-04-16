# BaSys Docker Environment

This repository contains a stack of Docker-Compose stacks that build upon each other: `admin, communication, aas, controlcomponents, processcontrol`

## Prerequisites

 1) Install [Docker](https://docs.docker.com/install/), 
    * e.g., in a [Ubuntu VM](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
      * If you [add your user to the docker group](https://docs.docker.com/install/linux/linux-postinstall/), you don't have to prefix your docker/docker-compose commands with `sudo`.
	* or in [Windows using WSL2 and Docker Desktop](https://nickjanetakis.com/blog/a-linux-dev-environment-on-windows-with-wsl-2-docker-desktop-and-more) (tested with 3.5.1)
 2) Install [Docker-Compose](https://docs.docker.com/compose/cli-command/#installing-compose-v2)
    * Docker-Compose is already available in Docker Desktop.

## Installation

1) Clone this repo `git clone https://github.com/BaSys-PC1/docker.git`
2) Inside the `.env` file, specify the `HOSTNAME` variable. For a local deployment, e.g. for developing purposes on the same machine, `HOSTNAME` can be set to `localhost`. If services need to be accessed from external clients, provide a routable IP address or hostname.
3) Create the Docker stacks either in one shot by `.\up.sh -a` or individually by
```bash
.\up.sh -s "admin communication aas controlcomponents processcontrol"
```
4) If you create the stacks individually, you do not need to create all of them but a sublist starting from `admin`. In that case, pay attention to a correct sequence of the stacks in the list, e.g.
```bash
.\up.sh -s "admin communication aas"
```
## Deinstallation

1) Just do a `.\down.sh -a` or individually by
```bash
.\down.sh -s "processcontrol controlcomponents aas communication admin"
```
2) Again, you can partially delete the stacks from the top `processcontrol` stack keeping the reverse order, e.g.
```bash
.\down.sh -s "processcontrol controlcomponents"
```
3) You might also want to delete unused volumes `docker volume prune`

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
| MQTT Broker                 | 1883 (tcp), 8883 (ssl), 8083 (ws), 8084 (wss), 18083 (dashboard) | 
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

