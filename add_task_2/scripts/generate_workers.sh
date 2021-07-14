#!/bin/bash

FILENAME="/home/vagrant/workers.properties"

cat << EOF > $FILENAME
# Define workers
worker.list=loadbalancer,status

EOF

for ((i = 1; i <= $1; i++ ))
do
  ((number =  10 + i ))
  echo "worker.worker"$i".type=ajp13" >> $FILENAME
  echo "worker.worker"$i".host="$2$number >> $FILENAME
  echo "worker.worker"$i".port=8009" >> $FILENAME
  echo "worker.worker"$i".lbfactor="$i >> $FILENAME
  echo "" >> $FILENAME
done

list=''
for ((i = 1; i <= $1; i++ ))
do
  list+="worker$i,"
done

cat << EOF >> $FILENAME

# Set properties for loadbalancer
worker.loadbalancer.type=lb
worker.loadbalancer.balance_workers=${list::-1}

# Get statistics
worker.status.type=status
EOF
