#!/bin/bash

#Define the folders in which we will run `mvn package docker:build -DskipTests=true`


apps=("gateway" "app1-mysql" "app2-postgres" "app3-mongo")
for app in "${apps[@]}";
do
    ( cd $app && mvn package docker:build -DskipTests=true ) 
done
