#!/bin/bash
#connects to oob system to bridge port 443 to port 2000 on localhost
#accepts ip address of target system for ilo
#requires ctrl-c to quit
ssh -l nmurphree -N -L 2000:$1:443 -L 1999:$1:80 st11a00is-launchpad001 #17.172.128.17 
