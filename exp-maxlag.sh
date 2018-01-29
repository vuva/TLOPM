#/bin/bash
export n=$3
export SL_ONTIME=5
export SL_OFFTIME=3
export SL_EXPTIME=$2
export SL_FILE=$2
EXP_TYPE=$1
for ((i=1;i<=n;i++)); do
echo "==== Running Test No. $i/$n ===="
export SL_I=$i

ssh vuva@pc22.filab.uni-hannover.de 'sudo sysctl -w net.mptcp.mptcp_scheduler=tagalong'
ssh vuva@pc21.filab.uni-hannover.de 'sudo sysctl -w net.mptcp.mptcp_scheduler=tagalong'
ssh vuva@pc21.filab.uni-hannover.de 'sudo sysctl -w net.mptcp.mptcp_maxlag=1'
ssh vuva@pc22.filab.uni-hannover.de 'sudo sysctl -w net.mptcp.mptcp_maxlag=1'
sleep 10
export SL_EX=$EXP_TYPE"-tag-1"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 20


ssh vuva@pc22.filab.uni-hannover.de 'sudo sysctl -w net.mptcp.mptcp_scheduler=tagalong'
ssh vuva@pc21.filab.uni-hannover.de 'sudo sysctl -w net.mptcp.mptcp_scheduler=tagalong'
ssh vuva@pc21.filab.uni-hannover.de 'sudo sysctl -w net.mptcp.mptcp_maxlag=4'
ssh vuva@pc22.filab.uni-hannover.de 'sudo sysctl -w net.mptcp.mptcp_maxlag=4'
sleep 10
export SL_EX=$EXP_TYPE"-tag-4"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 20


ssh vuva@pc22.filab.uni-hannover.de 'sudo sysctl -w net.mptcp.mptcp_scheduler=tagalong'
ssh vuva@pc21.filab.uni-hannover.de 'sudo sysctl -w net.mptcp.mptcp_scheduler=tagalong'
ssh vuva@pc21.filab.uni-hannover.de 'sudo sysctl -w net.mptcp.mptcp_maxlag=8'
ssh vuva@pc22.filab.uni-hannover.de 'sudo sysctl -w net.mptcp.mptcp_maxlag=8'
sleep 10
export SL_EX=$EXP_TYPE"-tag-8"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 20

ssh vuva@pc21.filab.uni-hannover.de 'sudo sysctl -w net.mptcp.mptcp_maxlag=1'
ssh vuva@pc22.filab.uni-hannover.de 'sudo sysctl -w net.mptcp.mptcp_maxlag=1'
done
rm ~/*.zip.*
echo done
