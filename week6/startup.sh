# run processes for the cluster
# running on a single dev machine

host="jomac-7.local"

cd /data/dbs

mkdir a0 2> /dev/null
mkdir a1 2> /dev/null
mkdir a2 2> /dev/null
mkdir b0 2> /dev/null
mkdir b1 2> /dev/null
mkdir b2 2> /dev/null
mkdir c0 2> /dev/null
mkdir c1 2> /dev/null
mkdir c2 2> /dev/null
mkdir d0 2> /dev/null
mkdir d1 2> /dev/null
mkdir d2 2> /dev/null

mkdir cfg0 2> /dev/null
mkdir cfg1 2> /dev/null
mkdir cfg2 2> /dev/null

# config servers
mongod --configsvr --dbpath cfg0 --port 26050 --fork --logpath log.cfg0 --logappend
mongod --configsvr --dbpath cfg1 --port 26051 --fork --logpath log.cfg1 --logappend
mongod --configsvr --dbpath cfg2 --port 26052 --fork --logpath log.cfg2 --logappend

# mongos processes, default mongo server port is 27017
mongos --configdb $host:26050,$host:26051,$host:26052 --fork --logpath log.mongos0 --logappend
mongos --configdb $host:26050,$host:26051,$host:26052 --fork --logpath log.mongos1 --logappend --port 26061
mongos --configdb $host:26050,$host:26051,$host:26052 --fork --logpath log.mongos2 --logappend --port 26062
mongos --configdb $host:26050,$host:26051,$host:26052 --fork --logpath log.mongos3 --logappend --port 26063

# shard servers (mongodb data servers)
# note:	don't use smallfiles nor such a small oplogSize in production; these are here running many on one machine
mongod --shardsvr --replSet a --dbpath a0 --logpath log.a0 --port 27000 --fork --logappend --smallfiles --oplogSize 50
mongod --shardsvr --replSet a --dbpath a1 --logpath log.a1 --port 27001 --fork --logappend --smallfiles --oplogSize 50
mongod --shardsvr --replSet a --dbpath a2 --logpath log.a2 --port 27002 --fork --logappend --smallfiles --oplogSize 50
mongod --shardsvr --replSet b --dbpath b0 --logpath log.b0 --port 27100 --fork --logappend --smallfiles --oplogSize 50
mongod --shardsvr --replSet b --dbpath b1 --logpath log.b1 --port 27101 --fork --logappend --smallfiles --oplogSize 50
mongod --shardsvr --replSet b --dbpath b2 --logpath log.b2 --port 27102 --fork --logappend --smallfiles --oplogSize 50
mongod --shardsvr --replSet c --dbpath c0 --logpath log.c0 --port 27200 --fork --logappend --smallfiles --oplogSize 50
mongod --shardsvr --replSet c --dbpath c1 --logpath log.c1 --port 27201 --fork --logappend --smallfiles --oplogSize 50
mongod --shardsvr --replSet c --dbpath c2 --logpath log.c2 --port 27202 --fork --logappend --smallfiles --oplogSize 50
mongod --shardsvr --replSet d --dbpath d0 --logpath log.d0 --port 27300 --fork --logappend --smallfiles --oplogSize 50
mongod --shardsvr --replSet d --dbpath d1 --logpath log.d1 --port 27301 --fork --logappend --smallfiles --oplogSize 50
mongod --shardsvr --replSet d --dbpath d2 --logpath log.d2 --port 27302 --fork --logappend --smallfiles --oplogSize 50

# print out startup info
ps -A | grep mongo | grep -v grep

tail -n 1 log.cfg0
tail -n 1 log.cfg1
tail -n 1 log.cfg2

tail -n 1 log.a0
tail -n 1 log.a1
tail -n 1 log.a2
tail -n 1 log.b0
tail -n 1 log.b1
tail -n 1 log.b2
tail -n 1 log.c0
tail -n 1 log.c1
tail -n 1 log.c2
tail -n 1 log.d0
tail -n 1 log.d1
tail -n 1 log.d2

tail -n 1 log.mongos0
tail -n 1 log.mongos1
tail -n 1 log.mongos2
tail -n 1 log.mongos3

