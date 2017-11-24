#/bin/bash
export n=$3
export SL_EXPTIME=$2
export SL_FILE=$2
EXP_TYPE=$1
for ((i=1;i<=n;i++)); do
echo "==== Running Test No. $i/$n ===="
export SL_I=$i

export SL_EX=$EXP_TYPE"dump-delay"
~/sshlauncher/sshlauncher $EXP_TYPE.config
sleep 20

done
rm ~/*.zip.*
echo done
