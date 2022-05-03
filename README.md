# BaSys Docker Environment

This repository contains a stack of Docker-Compose stacks that build upon each other: `admin, communication, aas, controlcomponents, processcontrol`

## Prerequisites

 1) Install [Docker](https://docs.docker.com/install/), 
    * e.g., in a [Ubuntu VM](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
      * If you [add your user to the docker group](https://docs.docker.com/install/linux/linux-postinstall/), you don't have to prefix your docker/docker-compose commands with `sudo`.
	* or in [Windows using WSL2 and Docker Desktop](https://nickjanetakis.com/blog/a-linux-dev-environment-on-windows-with-wsl-2-docker-desktop-and-more) (tested with 3.5.1)
 2) Install [Compose V2](https://docs.docker.com/compose/cli-command/#installing-compose-v2)
    * Docker Compose is already available in Docker Desktop.

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

## Service and Usage

After installation, the following services are available:

| Service | Stack | Ports / URL |
| ------ | ------ | ------ |
| Stack Overview           | admin           | http://[hostname] |
| Portainer                | admin           | http://[hostname]:9090, http://portainer.[hostname] |
| Apache Zookeeper         | communication   | 2181 | 
| Apache Kafka             | communication   | 9092 | 
| Schema Registry          | communication   | 8081 | 
| AKHQ (Kafka WebUI)       | communication   | http://[hostname]:8086, http://akhq.[hostname] | 
| EMQX (MQTT Broker)       | communication   | 1883 (tcp), 8883 (ssl), 8083 (ws), 8084 (wss), http://[hostname]:18083, http://emqx.[hostname] (dashboard) | 
| Elasticsearch            | aas             | 9200, 9300 | 
| Kibana                   | aas             | http://[hostname]:5601, http://kibana.[hostname] | 
| Neo4j                    | aas             | 7473, 7474, 7687,  http://neo4j.[hostname]  | 
| BaSys AAS Registry       | aas             | http://[hostname]:8020, http://aasregistry.[hostname]  |
| BaSys AAS Server         | aas             | http://[hostname]:4001/shells, http://aasserver.[hostname]/shells  |
| Camunda BPM Platform     | processcontrol  | http://[hostname]:9080/camunda, http://camunda.[hostname]  | 
| BaSys PPR Dashboard      | processcontrol  | http://[hostname]:8090, http://pprdashboard.[hostname]  |

In order to ease the use, the `admin` stack runs an nginx proxy that configures virtual hosts for certain services as well an nginx webserver for serving a static overview page on `http://[hostname]`:

<img src='/docs/stack-overview.png?raw=true' width='50%' height='50%'>


## Configuration

For the virtual hosts to work, you need to configure a DNS entry in you local router, e.g. pfsense. If that is not possible (e.g., because you run the stack in a bridged VM somewhere in your local network managed by a Fritzbox), you can extend your `hosts` file on your developer machine like so (please correct the IP adress):

```
# Added for BaSys Docker
192.168.178.59 dockerhost
192.168.178.59 portainer.dockerhost
192.168.178.59 akhq.dockerhost
192.168.178.59 emqx.dockerhost
192.168.178.59 kibana.dockerhost
192.168.178.59 neo4j.dockerhost
192.168.178.59 aasregistry.dockerhost
192.168.178.59 aasserver.dockerhost
192.168.178.59 camunda.dockerhost
192.168.178.59 pprdashboard.dockerhost
# As an example: also provide entries for virtual control components as they host control component submodels
192.168.178.59 mir100_1.dockerhost
192.168.178.59 drone_1.dockerhost
192.168.178.59 ur10_1.dockerhost
```

## Vagrant
(currently under development, coming soon)

## Troubleshooting

Problem:
The registry request to `/registry/shell-descriptors` returns an empty array.

Solution:
Restart the aas-server with `docker compose -f docker-compose-20-aas.yml -p aas restart aas-server`.
