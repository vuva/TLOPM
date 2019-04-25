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
export ROUTER=pc51.filab.uni-hannover.de


#: <<'END'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=redundant'
sleep 5
export SL_EX=$EXP_TYPE"-re"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 10

#ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=default'
#sleep 5
#export SL_EX=$EXP_TYPE"-lowrtt"
#~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
#sleep 10
#END
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=oppredundant'
sleep 5
export SL_EX=$EXP_TYPE"-opp"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 10

ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=lazytail'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_maxlag=1'
sleep 5
export SL_EX=$EXP_TYPE"-lazytail-1"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 10

#ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
#ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_desired_latency=20000'
#sleep 5
#export SL_EX=$EXP_TYPE"-newmonkey-20"
#~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
#sleep 10

ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_desired_latency=30000'
sleep 5
export SL_EX=$EXP_TYPE"-newmonkey-30"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 10

ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_desired_latency=40000'
sleep 5
export SL_EX=$EXP_TYPE"-newmonkey-40"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 10
END
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_desired_latency=50000'
sleep 5
export SL_EX=$EXP_TYPE"-newmonkey-50"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 10



ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_desired_latency=60000'
sleep 5
export SL_EX=$EXP_TYPE"-newmonkey-60"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 10

ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_desired_latency=90000'
sleep 5
export SL_EX=$EXP_TYPE"-newmonkey-90"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 10

ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_desired_latency=70000'
sleep 5
export SL_EX=$EXP_TYPE"-newmonkey-70"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 10

ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_desired_latency=80000'
sleep 5
export SL_EX=$EXP_TYPE"-newmonkey-80"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 10

END
: <<'END'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_desired_latency=100000'
sleep 5
export SL_EX=$EXP_TYPE"-newmonkey-100"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 10

ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_desired_latency=110000'
sleep 5
export SL_EX=$EXP_TYPE"-newmonkey-110"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 10

ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_desired_latency=120000'
sleep 5
export SL_EX=$EXP_TYPE"-newmonkey-120"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 10

ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_desired_latency=130000'
sleep 5
export SL_EX=$EXP_TYPE"-newmonkey-130"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 10

ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_desired_latency=140000'
sleep 5
export SL_EX=$EXP_TYPE"-newmonkey-140"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 10
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_desired_latency=150000'
sleep 5
export SL_EX=$EXP_TYPE"-newmonkey-150"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 10


ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_desired_latency=200000'
sleep 5
export SL_EX=$EXP_TYPE"-newmonkey-200"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 10


END
#ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
#ssh vuva@$SERVER 'sudo sysctl -w net.mptcp.mptcp_scheduler=monkeytail'
#ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_maxlag=8'
#ssh vuva@$SERVER 'sudo sysctl -w net.mptcp.mptcp_maxlag=8'
#sleep 5
#export SL_EX=$EXP_TYPE"-monkeytail-8"
#~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
#sleep 10

#ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=roundrobin'
#ssh vuva@$SERVER 'sudo sysctl -w net.mptcp.mptcp_scheduler=roundrobin'
#sleep 5
#export SL_EX=$EXP_TYPE"-rr"
#~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
#sleep 10
#END

: <<'END'

ssh vuva@$CLIENT 'sudo ip link set dev eth2 multipath off'
sleep 5
export SL_EX=$EXP_TYPE"-sp"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
ssh vuva@$CLIENT 'sudo ip link set dev eth2 multipath on'
sleep 10

ssh vuva@$CLIENT 'sudo python progmp_helper.py -f redundantSchedulerFlavor.progmp'
ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=rbs'

sleep 5
export SL_EX=$EXP_TYPE"-rbs"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 10






ssh vuva@$CLIENT 'sudo sysctl -w net.mptcp.mptcp_scheduler=tagalong'
ssh vuva@$SERVER 'sudo sysctl -w net.mptcp.mptcp_scheduler=tagalong'
sleep 5
export SL_EX=$EXP_TYPE"-tag"
~/sshlauncher/sshlauncher outage-$EXP_TYPE.config
sleep 10

END

done
rm ~/*.zip.*
echo done
