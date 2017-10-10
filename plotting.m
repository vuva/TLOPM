RTT=0.1;
% rr_dat =cell2mat(loadjson('roundrobin-interupted-data.json')); 
% re_dat=cell2mat(loadjson('redundant-interupted-data.json')); 
% rr_latency =[rr_dat.arrival_time].' -  [rr_dat.departure_time].'; 
% re_latency =[re_dat.arrival_time].' -  [re_dat.departure_time].';
prefix='D:\Data\'
distribution_name = 'on5-off3';
exp_name = 'wget-interupted';
lrtt_latency=[];
rr_latency=[];
re_latency=[];
for i=2:5
    lrtt_dat = csvread(strcat(prefix,exp_name,'-lowrtt-',distribution_name, '-',num2str(i), '.dat' ));
    rr_dat = csvread(strcat(prefix,exp_name,'-rr-',distribution_name, '-', num2str(i), '.dat' ));
    re_dat = csvread(strcat(prefix,exp_name,'-re-',distribution_name, '-', num2str(i), '.dat' ));
    lrtt_latency=vertcat(lrtt_latency,lrtt_dat(:,5)-lrtt_dat(:,4));
    rr_latency=vertcat(rr_latency,rr_dat(:,5)-rr_dat(:,4));
    re_latency=vertcat(re_latency,re_dat(:,5)-re_dat(:,4));
end

% figure 
% area(rr_latency/RTT);
% 
% figure 
% area(re_latency/RTT);

figure 
ksdensity(lrtt_latency/RTT);
hold on;
ksdensity(rr_latency/RTT);
hold on;
ksdensity(re_latency/RTT);
legend('LowRTT','RR','Redundant')

figure 
cdfplot(log(lrtt_latency/RTT));
hold on;
cdfplot(log(rr_latency/RTT));
hold on;
cdfplot(log(re_latency/RTT));
legend('LowRTT','RR','Redundant')

% figure
% x = [lrtt_latency/RTT;rr_latency/RTT;re_latency/RTT];
% g = [ones(size(lrtt_latency/RTT)); 2*ones(size(rr_latency/RTT)); 3*ones(size(re_latency/RTT))];
% boxplot(x,g)