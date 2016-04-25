# The Hipster of All Demos

Contributions are welcome.

## Summary
This project demonstrates the use of JHipster 3 and docker to build a microservice architecture.

It allows you to run:
- The JHipster registry
- An API Gateway
- Several microservices (app1, app2, etc.) based on different databases.
- The ELK stack (Elasticsearch, Logstash, Kibana) for log centralization
- _(future) Graphite/Grafana for metrics centralization_

#### **All working out of the box !**

It provides:
- Scripts to setup the apps (you need to have jhipster and jhipster-uml installed) 
- `.yo-rc.json` files in app1, app2, app3, app4 directory that will be used to generate JHipster apps
- A `central-server-config/` directory that can be used to edit the registry's config server configuration but _only in dev profile_ (a git repository is used in prod profile)

It depends on [generator-jhipster-docker-compose](https://github.com/jhipster/generator-jhipster-docker-compose) to generate a global docker-compose file.

## How to test

### Setup and build
First, generate all JHipster apps from their _.yo-rc.json_.

    ./setup-apps.sh
    
Then, generate samples entities from the _entities.jh_ JDL file in each app's directory

    ./setup-entities.sh

Finally, build apps and generate docker images for them.  `mvn package docker:build -DskipTests=true`

    ./build-apps.sh
    
This script runs `mvn package docker:build -DskipTests=true` for all apps, the `app/src/main/docker/Dockerfile` is used by maven-docker plugin to build the docker image.

Generate a Docker-compose file:

    yo jhipster:docker-compose

And answer the questions.


### Run everything

Note: At any point in the process you can use `docker-compose logs appname` to view its logs.

#### Start the JHipster Eegistry (service discovery and configuration server)

- `docker-compose up -d jhipster-registry`: launch the registry
- Open `http://localhost:8761/` to view the Eureka console (new microservices instances will automatically register themselves and show up here)
- Open `http://localhost:8761/config/application-dev.yml` to have a look at the properties that are transfered to all apps in the dev profile. You can edit them in the `/central-server-config` directory.

#### ELK (log centralization)

- `docker-compose up -d elk-elasticsearch elk-logstash elk-kibana`
- Open Kibana: `http://localhost:5601`, all logs will show up here.

#### Gateway and microservices

Start the Gateway with:
- `docker-compose up -d gateway`

It should connect with the registry and show up in the Eureka console.
- Open the gateway's admin panel: `http://localhost:8080/#/gateway` (log in with admin/admin)

Also logs should have started to show up in Kibana.

Start app1 with:
- `docker-compose up -d app1`

Start the other apps:
- `docker-compose up -d app2 app3`

#### Scale your apps

You can scale an app by creating **multiple instances** of it (doesn't work on the gateway or other apps that have their ports binded to localhost):
- `docker-compose scale app1=2`
- `docker-compose scale app2=3`

Then wait for them to show up at `http://localhost:8761/` and `http://localhost:8080/#/gateway`.

#### Stop an app
- `docker-compose stop appname`


## Shutdown and clean up
- Simply run `docker-compose down`
The following commands may prove useful:
- `docker stop $(docker ps -a -q)`: Stop all running containers
- Then `docker rm $(docker ps -a -q)`: Remove all containers

## TODO
- Switch between dev and prod ~~with an environment variable~~ different compose files.
- Boot up the database by extending src/main/docker/prod.yml
- (Bonus) Use log_driver to forward database logs to ELK through syslog

