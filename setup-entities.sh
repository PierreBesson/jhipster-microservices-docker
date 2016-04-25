#!/bin/bash

#Define the folders in which we will run `jhipster-uml entities.jh`

apps=("app1" "app2" "app3" "app4")
for app in "${apps[@]}";
do
    ( cd $app && jhipster-uml entities.jh )
done
