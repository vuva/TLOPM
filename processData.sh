n=$2
EXPNAME=$1
for ((i=1;i<=n;i++)); do
python3.6 ~/logs/outage/pcapProcess.py -p MPTCP -sf $EXPNAME-lowrtt-sender-$i.csv -rf $EXPNAME-lowrtt-receiver-$i.csv -saddr 10.1.2.2 10.1.3.2 -daddr 10.1.1.2 -o $EXPNAME-lowrtt-$i.dat
python3.6 ~/logs/outage/pcapProcess.py -p MPTCP -sf $EXPNAME-rr-sender-$i.csv -rf $EXPNAME-rr-receiver-$i.csv -saddr 10.1.2.2 10.1.3.2 -daddr 10.1.1.2 -o $EXPNAME-rr-$i.dat
python3.6 ~/logs/outage/pcapProcess.py -p MPTCP -sf $EXPNAME-re-sender-$i.csv -rf $EXPNAME-re-receiver-$i.csv -saddr 10.1.2.2 10.1.3.2 -daddr 10.1.1.2 -o $EXPNAME-re-$i.dat
python3.6 ~/logs/outage/pcapProcess.py -p MPTCP -sf $EXPNAME-sp-sender-$i.csv -rf $EXPNAME-sp-receiver-$i.csv -saddr 10.1.2.2 10.1.3.2 -daddr 10.1.1.2 -o $EXPNAME-sp-$i.dat
done
