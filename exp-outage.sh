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

ssh vuva@pc22.filab.uni-hannover.de 'sudo sysctl -w net.mptcp.mptcp_scheduler=redundant'
ssh vuva@pc21.filab.uni-hannover.de 'sudo sysctl -w net.mptcp.mptcp_scheduler=redundant'
sleep 10
export SL_EX=$EXP_TYPE"-interupted-re-on"$SL_ONTIME"-off"$SL_OFFTIME
ssh vuva@172.23.90.219 'sudo dagsnap -d0 -v -o '$SL_EX'.erf &'
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
ssh vuva@172.23.90.219 'sudo killall -INT dagsnap'
sleep 20


ssh vuva@pc22.filab.uni-hannover.de 'sudo sysctl -w net.mptcp.mptcp_scheduler=roundrobin'
ssh vuva@pc21.filab.uni-hannover.de 'sudo sysctl -w net.mptcp.mptcp_scheduler=roundrobin'
sleep 10
export SL_EX=$EXP_TYPE"-interupted-rr-on"$SL_ONTIME"-off"$SL_OFFTIME
ssh vuva@172.23.90.219 'sudo dagsnap -d0 -v -o '$SL_EX'.erf &'
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
ssh vuva@172.23.90.219 'sudo killall -INT dagsnap'
sleep 20

ssh vuva@pc22.filab.uni-hannover.de 'sudo sysctl -w net.mptcp.mptcp_scheduler=default'
ssh vuva@pc21.filab.uni-hannover.de 'sudo sysctl -w net.mptcp.mptcp_scheduler=default'
sleep 10
export SL_EX=$EXP_TYPE"-interupted-lowrtt-on"$SL_ONTIME"-off"$SL_OFFTIME
ssh vuva@172.23.90.219 'sudo dagsnap -d0 -v -o '$SL_EX'.erf &'
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
ssh vuva@172.23.90.219 'sudo killall -INT dagsnap'
sleep 20

ssh vuva@pc22.filab.uni-hannover.de 'sudo ip link set dev eth2 multipath off'
sleep 10
export SL_EX=$EXP_TYPE"-interupted-sp-on"$SL_ONTIME"-off"$SL_OFFTIME
ssh vuva@172.23.90.219 'sudo dagsnap -d0 -v -o '$SL_EX'.erf &'
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
ssh vuva@172.23.90.219 'sudo killall -INT dagsnap'
ssh vuva@pc22.filab.uni-hannover.de 'sudo ip link set dev eth2 multipath on'
sleep 20

done
rm ~/*.zip.*
echo done
