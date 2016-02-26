#!/bin/bash

#Define the folders in which we will run `yo jhipster`

apps=("gateway" "app1-mysql" "app2-postgres" "app3-mongo")
for app in "${apps[@]}";
do
    ( cd $app && yo jhipster ) 
done
