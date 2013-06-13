# run processes for the cluster
# running on a single dev machine

host="jomac-7.local"

cd db

mkdir s1 2> /dev/null
mkdir s2 2> /dev/null

mkdir cfg0 2> /dev/null

# config servers
mongod --configsvr --dbpath cfg0 --port 27019 --fork --logpath log.cfg0 --logappend

# mongos processes, default mongo server port is 27017
mongos --configdb localhost:27019 --fork --logpath log.mongos0 --logappend

# shard servers (mongodb data servers)
# note:	don't use smallfiles nor such a small oplogSize in production; these are here running many on one machine
mongod --shardsvr --dbpath s1 --logpath log.s1 --port 27501 --fork --logappend --smallfiles --oplogSize 50
mongod --shardsvr --dbpath s2 --logpath log.s2 --port 27601 --fork --logappend --smallfiles --oplogSize 50

