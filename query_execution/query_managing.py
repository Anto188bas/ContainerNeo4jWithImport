import time
import json
from   neo4j import GraphDatabase
from   multiprocessing import Process


def do_activations(line, path, session):
    print(line + "\n")
    line = line.split("\t")[0].replace("\n","")
    tick = time.time()
    result = session.run(line)
    nof = next(iter(result))["count(n1)"]
    elapsed = time.time() - tick
    with open(path, 'a') as output:
        output.write(line + '\t' + str(nof) + '\t' + str(elapsed) + "\n")
        output.close()


configurator = json.load(open("query_conf.json"))
for line_ in open(configurator["query_file"]):
    driver   = GraphDatabase.driver(
        "{}:{}".format(configurator["host"], configurator["port"]),
        auth      = (configurator["username"], configurator["password"]),
        encrypted = False
    )
    session_ = driver.session()

    active_process = Process(target = do_activations, args = (line_, configurator["results"], session_))
    active_process.start()
    active_process.join(timeout = 1800)
    active_process.terminate()

    driver.close()