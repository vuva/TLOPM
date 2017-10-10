export EXP_NAME=on5-off3
export n=5
for ((i=1;i<=n;i++)); do
echo "==== Running Test No. $i ===="
python3.6 pcapProcess.py -p MPTCP -sf iperf-interupted-lowrtt-$EXP_NAME-sender-$i.csv -rf iperf-interupted-lowrtt-$EXP_NAME-receiver-$i.csv -o iperf-interupted-lowrtt-$EXP_NAME-$i.dat -saddr 10.1.4.2 10.1.6.2 -daddr 10.1.2.2
python3.6 pcapProcess.py -p MPTCP -sf iperf-interupted-rr-$EXP_NAME-sender-$i.csv -rf iperf-interupted-rr-$EXP_NAME-receiver-$i.csv -o iperf-interupted-rr-$EXP_NAME-$i.dat -saddr 10.1.4.2 10.1.6.2 -daddr 10.1.2.2
python3.6 pcapProcess.py -p MPTCP -sf iperf-interupted-re-$EXP_NAME-sender-$i.csv -rf iperf-interupted-re-$EXP_NAME-receiver-$i.csv -o iperf-interupted-re-$EXP_NAME-$i.dat -saddr 10.1.4.2 10.1.6.2 -daddr 10.1.2.2

python3.6 pcapProcess.py -p MPTCP -sf wget-interupted-lowrtt-$EXP_NAME-sender-$i.csv -rf wget-interupted-lowrtt-$EXP_NAME-receiver-$i.csv -o wget-interupted-lowrtt-$EXP_NAME-$i.dat -saddr 10.1.4.2 10.1.6.2 -daddr 10.1.2.2
python3.6 pcapProcess.py -p MPTCP -sf wget-interupted-rr-$EXP_NAME-sender-$i.csv -rf wget-interupted-rr-$EXP_NAME-receiver-$i.csv -o wget-interupted-rr-$EXP_NAME-$i.dat -saddr 10.1.4.2 10.1.6.2 -daddr 10.1.2.2
python3.6 pcapProcess.py -p MPTCP -sf wget-interupted-re-$EXP_NAME-sender-$i.csv -rf wget-interupted-re-$EXP_NAME-receiver-$i.csv -o wget-interupted-re-$EXP_NAME-$i.dat -saddr 10.1.4.2 10.1.6.2 -daddr 10.1.2.2

done