# PROCEDURES
<br/>

The image allows you to load a network within neo4j db by using the neo4j-admin tool

<br></br>
<b>Example nodes.csv</b>

    id:ID,labels:LABEL,prop_1,prop_2,...prop_n
    0,A:B:C,0.5,0.7,...,12
    ........
    ........
    ........

    10,B,0.4,0.3,....,2

<br></br>

<b>Example edges.csv</b>

    src:START_ID,dst:END_ID,type:TYPE,prop_a,...,prop_m
    0,10,X,20,...,10

Note: 0 and 10 are nodes' id. Such ids have to be in id:ID of the file nodes.csv.

<br></br>
#### CREATION

Before to run the docker-compose you need to:
  
  1. Create the directory "networks"
  2. Insert into "networks", the directory (<network_dir_name>) containing nodes and edges file. Such a directory is like that:

     <network_dir_name>

       - nodes.csv
       - edges.csv
       - query/query.txt
       - results (it is a directory where the timing 
      
  4. Configure loading.properties (ubder the directory init_network)
  6. run docker-compose.yaml

<b>NOTE</b>: 

Node file has to be a header like this:
  
  - id:ID, labels:LABEL, properties: 
    
    If the file does not have such configuration, you could use such command:

    <b>sed -i '1s/.*/id:ID,labels:LABEL,properties/' /path/nodes.csv</b>

Edge file has to be header like this:

  - src:START_ID,dst:END_ID,type:TYPE,properties

    If the file does not have such configuration, you could use such command:

    <b>sed -i '1s/.*/src:START_ID,dst:END_ID,type:TYPE/' /path/edges.csv</b>

<br></br>

#### RUN QUERIES

You could run de queries as follows:

    docker exec -it <container_id> /bin/bash
    cd /scripts
    nano query_conf.json
    # update the fileds on the basis of your network
    screen python3 query_managing.py
    
