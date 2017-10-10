#/bin/bash
export n=1
export SL_ONTIME=10
export SL_OFFTIME=3
export SL_EXPTIME=$2
export SL_FILE=$2 
EXP_TYPE=$1
for ((i=1;i<=n;i++)); do
echo "==== Running Test No. $i/$n ===="
export SL_I=$i

ssh vuva@pc21.filab.uni-hannover.de 'sudo sysctl -w net.mptcp.mptcp_scheduler=default'
ssh vuva@pc48.filab.uni-hannover.de 'sudo sysctl -w net.mptcp.mptcp_scheduler=default'
sleep 10
export SL_EX=$EXP_TYPE"-interupted-lowrtt-on10-off3"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 20

ssh vuva@pc21.filab.uni-hannover.de 'sudo sysctl -w net.mptcp.mptcp_scheduler=roundrobin'
ssh vuva@pc48.filab.uni-hannover.de 'sudo sysctl -w net.mptcp.mptcp_scheduler=roundrobin'
sleep 10
export SL_EX=$EXP_TYPE"-interupted-rr-on10-off3"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 20

ssh vuva@pc21.filab.uni-hannover.de 'sudo sysctl -w net.mptcp.mptcp_scheduler=redundant'
ssh vuva@pc48.filab.uni-hannover.de 'sudo sysctl -w net.mptcp.mptcp_scheduler=redundant'
sleep 10
export SL_EX=$EXP_TYPE"-interupted-re-on10-off3"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 20

done
echo done