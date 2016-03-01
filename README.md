# The Hipster of All Demos

Contributions are welcome. Please check that you are using recent versions of docker and docker-compose.

## Summary
This demo demonstrate the use of JHipster 3 and docker to build a microservice architecture.

It allows you to run:
- The JHipster registry
- An API Gateway
- Several microservices (app1, app2, etc.) based on different databases.
- The ELK stack (Elasticsearch, Logstash, Kibana) for log centralization

#### **All working out of the box !**

It provides:
- Scripts to setup the apps (you need to have jhipster and jhipster-uml installed) 
- `.yo-rc.json` files in app1, app2, app3 directory that will be used to generate JHipster apps
- A `central-server-config/` directory that can be used to edit the registry's config server configuration but _only in dev profile_ (a git repository is used in prod profile)
- Docker compose files to orchestrate docker containers


## How to test
- `./setup-apps.sh` : run `yo jhipster --force --with-entities` for all apps. This generate JHipster apps from their _.yo-rc.json_.
- `./setup-entities.sh` : run `jhipster-uml entities.jh` for all apps. This generates entities from the _entities.jh_ JDL file in this app folder.
- `mvn package -DskipTests=true`: build all apps
- `docker-compose up`: launch everything at once

### Super compose
Alternate way to manage docker images
- `./build-apps.sh` run `mvn package docker:build -DskipTests=true ` for all apps. This builds apps and generates docker images using `src/main/docker/Dockerfile`.
- `./build-apps.sh`: `mvn package docker:build -Pprod -DskipTests=true` for all apps.
- `docker-compose -f super-compose-dev.yml up`

## How to shutdown and clean up
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
