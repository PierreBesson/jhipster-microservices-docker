#!/bin/bash

#Define the folders in which we will run `mvn package docker:build -Pprod -DskipTests=true`


apps=("gateway" "app1" "app2" "app3")
for app in "${apps[@]}";
do
    ( cd $app && mvn package docker:build -Pprod -DskipTests=true ) 
done
