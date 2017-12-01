filename=strcat(prefix,'iperf-dump-delay-1.log');
cwnd_dat = csvread(strcat(prefix,'sender-cwnd-2', '.csv' ));

for i=1:size
    cwnd = dat{1,1}.intervals{1,i}.streams{1,1}.snd_cwnd;
    cwnd_dat(i)=cwnd;
    
end
figure
% yyaxis left;
scatter(sp_dat(:,1),sp_dat(:,6),'MarkerEdgeColor','blue');
hold on;
scatter(sp_dat(:,1),sp_dat(:,7),'MarkerEdgeColor','green');
hold on;
scatter(spdag_dat(:,1),spdag_dat(:,6),'MarkerEdgeColor','cyan');
hold on;
scatter(spdag_dat(:,1),spdag_dat(:,7),'MarkerEdgeColor','red');
legend('tcpdump-send','tcpdump-recv','dag-send','dag-recv');
hold on;
yyaxis right;
plot (cwnd_dat(:,1),cwnd_dat(:,2));

figure;
yyaxis left;
area(spdag_dat(:,6),offset);
hold on;
yyaxis right;
plot (cwnd_dat(:,1),cwnd_dat(:,2));
