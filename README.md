# The Hipster of All Demos

Contributions are welcome. Please check that you are using recent versions of docker and docker-compose.

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
- `.yo-rc.json` files in app1, app2, app3 directory that will be used to generate JHipster apps
- A `central-server-config/` directory that can be used to edit the registry's config server configuration but _only in dev profile_ (a git repository is used in prod profile)
- Docker compose files to orchestrate docker containers


## How to test

### Setup and build
- `./setup-apps.sh` : run `yo jhipster --force --with-entities` for all apps. This generate JHipster apps from their _.yo-rc.json_.
- `./setup-entities.sh` : run `jhipster-uml entities.jh` for all apps. This generates entities from the _entities.jh_ JDL file in this app folder.
- `./build-apps.sh` run `mvn package docker:build -DskipTests=true ` for all apps. This builds apps and generates docker images using `src/main/docker/Dockerfile`.
- _(or for prod) `./build-apps-prod.sh`: `mvn package docker:build -Pprod -DskipTests=true` for all apps._

### Run the architecture

At any moment you can use `docker-compose logs appname` to view its logs.

#### Jhipster-registry (service discovery and config server)

- `docker-compose up -d jhipster-registry`: launch the registry
- Open `http://localhost:8761/` to view the Eureka console (new microservices instances will automatically register themselves and show up here)
- Open `http://localhost:8761/config/application-dev.yml` to have a look at the properties that are transfered to all apps in the dev profile. You can edit them in the `/central-server-config`.

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
- `docker-compose up -d app1-mysql`

Start the other apps:
- `docker-compose up -d app2-postgres app3-mongo`

#### Scale your apps

You can scale an app by creating **multiple instances** of it (doesn't work on the gateway or other apps that have their ports binded to localhost):
- `docker-compose scale app1-mysql=2`
- `docker-compose scale app2-postgres=3`

Then wait for them to show up at `http://localhost:8761/` and `http://localhost:8080/#/gateway`.

#### Stop an app
- `docker-compose stop appname`


## Shutdown and clean up
- Simply run `docker-compose down`
The following commands may prove useful:
- `docker stop $(docker ps -a -q)`: Stop all running containers
- Then `docker rm $(docker ps -a -q)`: Remove all containers

## Rules
- The JHipster Registry must be run from the docker hub image
- Keep only .yo-rc.json and entities.jh in the apps folders
- Gateway and microservices must be generated from generator-jhipster's latest master (clone latest master and run `npm link`)

## Guidelines:
- Dev and Prod profiles setups must be tested
- Use only Maven for now
- Use the power of Docker Compose v2

## TODO
- Switch between dev and prod ~~with an environment variable~~ different compose files.
- Boot up the database by extending src/main/docker/prod.yml
- (Bonus) Use log_driver to forward database logs to ELK through syslog

## Future
- Think about automating deployment to cloud platforms (AWS, Cloudfoundry, etc...) and orchestration on multiple hosts (Docker Swarm ?).
