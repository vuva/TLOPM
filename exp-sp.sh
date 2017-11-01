#/bin/bash
export n=$3
EXP_TYPE=$1
export SL_EXPTIME=$2
export SL_FILE=$2
for ((i=1;i<=n;i++)); do
echo "==== Running Test No. $i/$n ===="
export SL_I=$i
export SL_EX=$EXP_TYPE
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 20

done
echo done
