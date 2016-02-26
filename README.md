# The Hipster of All Demos

Contributions are welcome.

## How to test
- `./setup.sh` : run `yo jhipster` for all app
- `mvn package`: build all apps
- `docker-compose up`: launch everything at once

## Rules
- Registry must be run from the docker hub image
- Keep only .yo-rc.json in the apps folders
- Gateway and microservices must be generated from generator-jhipster's latest master using `yo jhipster`
- JWT secret key must be the same for all apps.

## Guidelines:
- Dev and Prod profiles setups must be tested
- Use only Maven for now
- Use the power of Docker Compose v2

## TODO
- Fix ELK in docker-compose.yml
- Create a global Dockerfile to build the war for every app (so that if the source has changed, the docker-compose can rebuild the images as needed)
- Split up the docker compose files in subfiles (in each app dir?)
- Switch between dev and prod with an environment variable
- Boot up the database by extending src/main/docker/prod.yml
- (Bonus) Use log_driver to forward database logs to ELK through syslog
