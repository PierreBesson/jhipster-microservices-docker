#!/bin/bash

#Define the folders in which we will run `yo jhipster`

apps=("gateway" "app1" "app2" "app3" "app4")
for app in "${apps[@]}";
do
    ( cd $app && yo jhipster --force --with-entities ) 
done
