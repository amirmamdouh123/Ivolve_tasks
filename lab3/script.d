#!/bin/bash

IP="192.168.1."
for i in {2..254} ;do
       
	
	ping -c 1 -W 1 ${IP}${i} > /dev/null 2> /dev/null     //ping itself runs for infinity -> you need to specify sending one packet only + timeout
         
        if [[ $? == 0 ]] ; then 
           echo "server ${IP}${i} is up and running......"
         	
	 else
	 	echo "server ${IP}${i} is down"
	 fi

 done
