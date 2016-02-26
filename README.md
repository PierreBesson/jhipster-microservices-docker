## JHipster microservices docker

- Registry must be run from the docker hub image
- Keep only .yo-rc.json in the apps folders
- Gateway and microservices must be generated from generator-jhipster's latest master using `yo jhipster`
- JWT secret key must be the same for all apps.

Guidelines:
- Dev and Prod profiles must be tested
- Use only Maven for now
- Use the power of Docker Compose v2
