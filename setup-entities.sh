#!/bin/bash

#Define the folders in which we will run `jhipster-uml entities.jh`

apps=("app1-mysql" "app2-postgres" "app3-mongo")
for app in "${apps[@]}";
do
    ( cd $app && jhipster-uml entities.jh )
done
