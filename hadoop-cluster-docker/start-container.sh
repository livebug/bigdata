#!/bin/bash

# the default node number is 3
N=${1:-4}


# start hadoop master container
sudo docker rm -f hadoop-master &> /dev/null
echo "start hadoop-master container..."
sudo docker run -itd \
                --net=hadoop \
                -p 9870:9870 \
                -p 9867
                -p 8088:8088 \
                -p 19888:19888 \
                -p 10000:10000 \
                -p 9999:9999 \
                -p 8042:8042 \
                --name hadoop-master \
                --hostname hadoop-master \
                -v /opt/hadoop:/opt \
                livebug/hadoop:3.3.0 &> /dev/null


# start hadoop slave container
i=1
while [ $i -lt $N ]
do
	sudo docker rm -f hadoop-slave$i &> /dev/null
	echo "start hadoop-slave$i container..."
	sudo docker run -itd \
	                --net=hadoop \
	                --name hadoop-slave$i \
                    -p $i8042:8042 \
	                --hostname hadoop-slave$i \
	                livebug/hadoop:3.3.0 &> /dev/null
	i=$(( $i + 1 ))
done 

# get into hadoop master container
sudo docker exec -it hadoop-master bash
