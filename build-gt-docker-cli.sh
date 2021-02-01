#!/bin/bash

ID_DEMO=id_demo_rsa
rm -f $ID_DEMO $ID_DEMO.pub
ssh-keygen -f $ID_DEMO -P '' -t rsa -b 4096 -C "$ID_DEMO@example.com" 

DOCKER_BUILDKIT=1 docker build \
    --no-cache \
    --secret id=myid_rsa,src=$ID_DEMO \
    --secret id=myid_rsa.pub,src=$ID_DEMO.pub \
    -t glamorousdocker .
