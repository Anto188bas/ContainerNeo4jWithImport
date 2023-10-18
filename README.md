# PROCEDURES
<br/>

#### CREATION

Before to run the docker-compose you need to:
  
  1. Create the directory "networks"
  2. Insert under such directory, the network one having nodes and edges file
  3. configure loading.properties
  4. run docker-compose.yaml

NOTE: 

Node file has to be a header like this:
  
  - id:ID, labels:LABEL, properties: 
    
    If the file does not have such configuration, you could use such command:

    <b>sed -i '1s/.*/id:ID,labels:LABEL,properties/' /path/nodes.csv</b>

Edge file has to be header like this:

  - src:START_ID,dst:END_ID,type:TYPE,properties

    If the file does not have such configuration, you could use such command:

    <b>sed -i '1s/.*/src:START_ID,dst:END_ID,type:TYPE/' /path/edges.csv</b>    