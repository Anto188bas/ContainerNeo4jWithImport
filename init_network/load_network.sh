#!/bin/bash

CONTAINER_ALREADY_STARTED="CONTAINER_ALREADY_STARTED_PLACEHOLDER"

if [ ! -e $CONTAINER_ALREADY_STARTED ]
then
   touch $CONTAINER_ALREADY_STARTED
   echo "NEO4J NETWORK LOADING"

   # ARRAY DECLARATION
   declare -A props

   # REMOVE DATA
   rm -r data/*

   # PROPERTY CONFIGURATION
   file_prop=init_network/loading.properties
   while IFS='=' read -r key value;
   do
      props["$key"]="$value"
   done < "$file_prop"

   # COMMAND COMPOSITION
   command="bin/neo4j-admin import "

   # NODE PART CONFIGURATION
   for file in import/${props["network_dir"]}/nodes/*
   do
      command="$command --nodes=$file"
   done

   # EDGE PART CONFIGURATION
   for file in import/${props["network_dir"]}/edges/*
   do
      command="$command --relationships=$file"
   done

   # ADD DELIMITERS PART
   command="$command"' --delimiter='${props["delimiter"]}
   command="$command"' --array-delimiter='${props["array_delimiter"]}

   echo $command

   # NETWORK LOADING
   /bin/bash $command
   chown -R neo4j:neo4j data/

   # PASSWORD CONFIGURATION
   gosu neo4j:neo4j neo4j-admin set-initial-password ${props["password"]}
fi

bin/neo4j console