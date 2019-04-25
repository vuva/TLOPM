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
export CLIENT=pc52.filab.uni-hannover.de
export SERVER=pc50.filab.uni-hannover.de


: <<'END'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=redundant'
ssh vuva@$SERVER 'sudo sysctl -w net.mptcp.mptcp_scheduler=redundant'
sleep 10
export SL_EX=$EXP_TYPE"-re"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 20

ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=default'
ssh vuva@$SERVER 'sudo sysctl -w net.mptcp.mptcp_scheduler=default'
sleep 10
export SL_EX=$EXP_TYPE"-lowrtt"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 20

ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=oppredundant'
ssh vuva@$SERVER 'sudo sysctl -w net.mptcp.mptcp_scheduler=oppredundant'
sleep 10
export SL_EX=$EXP_TYPE"-opp"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 20


ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=tagalong'
ssh vuva@$SERVER 'sudo sysctl -w net.mptcp.mptcp_scheduler=tagalong'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_maxlag=0'
ssh vuva@$SERVER 'sudo sysctl -w net.mptcp.mptcp_maxlag=0'
sleep 10
export SL_EX=$EXP_TYPE"-tag-0"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 20
#END
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=tagalong'
ssh vuva@$SERVER 'sudo sysctl -w net.mptcp.mptcp_scheduler=tagalong'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_maxlag=8'
ssh vuva@$SERVER 'sudo sysctl -w net.mptcp.mptcp_maxlag=8'
sleep 10
export SL_EX=$EXP_TYPE"-tag-8"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 20

END

ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_maxlag=0'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_tail_service_interval=1'
sleep 10
export SL_EX=$EXP_TYPE"-monkeytail-0-1"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 20

ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_maxlag=2'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_tail_service_interval=1'
sleep 10
export SL_EX=$EXP_TYPE"-monkeytail-2-1"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 20

ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_maxlag=2'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_tail_service_interval=2'
sleep 10
export SL_EX=$EXP_TYPE"-monkeytail-2-2"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 20


ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_maxlag=4'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_tail_service_interval=1'
sleep 10
export SL_EX=$EXP_TYPE"-monkeytail-4-1"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 20

ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_maxlag=4'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_tail_service_interval=2'
sleep 10
export SL_EX=$EXP_TYPE"-monkeytail-4-2"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 20


ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_maxlag=4'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_tail_service_interval=4'
sleep 10
export SL_EX=$EXP_TYPE"-monkeytail-4-4"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 20


ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_maxlag=8'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_tail_service_interval=1'
sleep 10
export SL_EX=$EXP_TYPE"-monkeytail-8-1"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 20


ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_maxlag=8'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_tail_service_interval=4'
sleep 10
export SL_EX=$EXP_TYPE"-monkeytail-8-4"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 20


ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_maxlag=8'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_tail_service_interval=8'
sleep 10
export SL_EX=$EXP_TYPE"-monkeytail-8-8"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 20


ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_maxlag=16'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_tail_service_interval=1'
sleep 10
export SL_EX=$EXP_TYPE"-monkeytail-16-1"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 20


ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_maxlag=16'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_tail_service_interval=4'
sleep 10
export SL_EX=$EXP_TYPE"-monkeytail-16-4"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 20


ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_maxlag=16'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_tail_service_interval=8'
sleep 10
export SL_EX=$EXP_TYPE"-monkeytail-16-8"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 20

#ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=roundrobin'
#ssh vuva@$SERVER 'sudo sysctl -w net.mptcp.mptcp_scheduler=roundrobin'
#sleep 10
#export SL_EX=$EXP_TYPE"-rr"
#~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
#sleep 20
#END

: <<'END'

ssh vuva@$CLIENT 'sudo ip link set dev eth2 multipath off'
sleep 10
export SL_EX=$EXP_TYPE"-sp"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
ssh vuva@$CLIENT 'sudo ip link set dev eth2 multipath on'
sleep 20

ssh vuva@$CLIENT 'sudo python progmp_helper.py -f redundantSchedulerFlavor.progmp'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=rbs'

sleep 10
export SL_EX=$EXP_TYPE"-rbs"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 20






ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=tagalong'
ssh vuva@$SERVER 'sudo sysctl -w net.mptcp.mptcp_scheduler=tagalong'
sleep 10
export SL_EX=$EXP_TYPE"-tag"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 20

END

done
rm ~/*.zip.*
echo done
