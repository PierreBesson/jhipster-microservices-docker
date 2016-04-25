#!/bin/bash

#Define the folders in which we will run `mvn package docker:build -DskipTests=true`


apps=("gateway" "app1" "app2" "app3" "app4")
for app in "${apps[@]}";
do
    ( cd $app && mvn package -Pprod docker:build -DskipTests ) 
done
