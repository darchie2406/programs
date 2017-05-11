#!/bin/bash

# Identify itrac binary
cd /usr/bin
itrac=$(ls | grep itrac-)

# Return to HOME
cd $HOME

# Grab Serial Number From iTrac
serial=$($itrac -x ./itrac_pass -q hostname=$1 -f serial_number 2>/dev/null | awk '{ if (NR==2) print $0 }')

# Grab Model From iTrac
model=$($itrac -x ./itrac_pass -q hostname=$1 -f product_description 2>/dev/null | sed 's/[\t ]//g' | awk '{ if (NR==2) print $0 }')

# Echo Results
echo $1
echo $model
echo $serial

# Generate IBM Variable
ibm=$(echo $model-$serial | sed 's/[\t ]//g')


# Connect to Host Using SSHPASS
if [ "ping -q -c1 ORACLESP-$serial 2>/dev/null | wc -l"="6" ]; then sshpass -pchangeme ssh root@ORACLESP-$serial 2>/dev/null
fi
if [ "ping -q -c1 SUNSP-$serial 2>/dev/null | wc -l"="6" ]; then sshpass -pchangeme ssh root@SUNSP-$serial 2>/dev/null
fi
if [ "ping -q -c1 ILO$serial 2>/dev/null | wc -l"="6" ]; then sshpass -pjumpm3 ssh Administrator@ILO$serial 2>/dev/null
fi
if [ "ping -q -c1 idrac-$serial 2>/dev/null | wc -l"="6" ]; then sshpass -pcalvin ssh root@idrac-$serial 2>/dev/null
fi
if [ "ping -q -c1 imm-$model-$serial 2>/dev/null | wc -l"="6" ]; then sshpass -pjumpm3 ssh Administrator@imm-$ibm 2>/dev/null
fi

# Connect to Host without SSHPASS
# if [ "ping -q -c1 ORACLESP-$serial 2>/dev/null | wc -l"="6" ]; then ssh root@ORACLESP-$serial 2>/dev/null
# fi
# if [ "ping -q -c1 SUNSP-$serial 2>/dev/null | wc -l"="6" ]; then ssh root@SUNSP-$serial 2>/dev/null
# fi
# if [ "ping -q -c1 ILO$serial 2>/dev/null | wc -l"="6" ]; then ssh Administrator@ILO$serial 2>/dev/null
# fi
# if [ "ping -q -c1 idrac-$serial 2>/dev/null | wc -l"="6" ]; then ssh root@idrac-$serial 2>/dev/null
# fi
# if [ "ping -q -c1 imm-$model-$serial 2>/dev/null | wc -l"="6" ]; then ssh "Administrator@imm-$ibm" 2>/dev/null
# fi
