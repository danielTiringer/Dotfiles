#!/bin/bash
echo $1
rsync -anvzuP ~/Projects/$1/ tiringerdaniel@192.168.10.211:/home/Schibsted/tiringerdaniel/docker-hasznaltauto/$1

