#!/bin/bash

msgsvcs=("http://us04prdmsga.company.local:8085/health" "http://us04prdmsgb.company.local:8085/health" "http://us04prdmsgc.company.local:8085/health" "http://us04prdmsgd.company.local:8085/health")
LOG_FILE="/Users/Zach/Development/GitHub Repos/Monitor-Lizard/svc.csv"

./logTimeStamp.sh

for i in ${msgsvcs[@]}
do
    printf $i >> $LOG_FILE 2>&1
    printf "," >> $LOG_FILE 2>&1
	curl -is $msgsvcs | head -n 1 >> $LOG_FILE 2>&1
done

printf "\n" >> $LOG_FILE 2>&1
