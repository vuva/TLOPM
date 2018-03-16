k=1;
n=10;
global RTT;
RTT=1;
set(0,'DefaultFigureWindowStyle','docked');
set(0,'DefaultLineLineWidth',1.5);
% rr_dat =cell2mat(loadjson('roundrobin-interupted-data.json')); 
% re_dat=cell2mat(loadjson('redundant-interupted-data.json')); 
% rr_latency =[rr_dat.arrival_time].' -  [rr_dat.departure_time].'; 
% re_latency =[re_dat.arrival_time].' -  [re_dat.departure_time].';
prefix='D:\Data\iperf-noloss-with-tagalong\';
distribution_name = 'on5-off3';
global exp_name;
exp_name = 'dag-iperf-noloss';
lrtt_latency=[];
rr_latency=[];
re_latency=[];
sp_latency=[];
rbs_latency=[];

for i=k:n
    lrtt_dat = csvread(strcat(prefix,exp_name,'-lowrtt-',num2str(i), '.dat' ));
    rr_dat = csvread(strcat(prefix,exp_name,'-lowrtt-', num2str(i), '.dat' ));
    re_dat = csvread(strcat(prefix,exp_name,'-re-', num2str(i), '.dat' ));
    sp_dat = csvread(strcat(prefix,exp_name,'-tag-', num2str(i), '.dat' ));
    rbs_dat = csvread(strcat(prefix,exp_name,'-opp-', num2str(i), '.dat' ));
    lrtt_latency=vertcat(lrtt_latency,lrtt_dat(50:end-50,10));
    rr_latency=vertcat(rr_latency,rr_dat(50:end-50,10));
    re_latency=vertcat(re_latency,re_dat(50:end-50,10));
    sp_latency=vertcat(sp_latency,sp_dat(50:end-50,10));
    rbs_latency=vertcat(rbs_latency,rbs_dat(50:end-50,10));
end
[lrtt_latency,rr_latency,re_latency,sp_latency,rbs_latency]=filterdata(lrtt_latency,rr_latency,re_latency,sp_latency,rbs_latency);
% plotcdf(lrtt_latency,rr_latency,re_latency,sp_latency);
% plotpdf(lrtt_latency,rr_latency,re_latency,sp_latency);

plotccdf(lrtt_latency,rr_latency,re_latency,sp_latency,rbs_latency);

function[]=plotccdf(lrtt_latency,rr_latency,re_latency,sp_latency,rbs_latency)
    global exp_name;
    
    figure
    
    getccdf(lrtt_latency);
    hold on;
    getccdf(rr_latency);
    hold on;
    getccdf(re_latency);
    hold on;
    getccdf(sp_latency);
    hold on;
    getccdf(rbs_latency);
    hold on;
    title(strcat('CCDF-',exp_name));
    legend('LowRTT','Tag','Redundant','Tagalong','OPP');   
    set(gca, 'YScale', 'log');
end

function[xccdf,yccdf] = getccdf(value)
    [ycdf,xcdf] = cdfcalc(value);
    xccdf = xcdf;
    yccdf = 1-ycdf(1:end-1);
    plot(xccdf,yccdf);
end
function[lrtt_latency,rr_latency,re_latency,sp_latency,rbs_latency]= filterdata(lrtt_latency,rr_latency,re_latency,sp_latency,rbs_latency)
lrtt_latency = lrtt_latency(lrtt_latency(:, end) >0.00, :);
lrtt_latency = lrtt_latency(lrtt_latency(:, end) <1, :);
rr_latency = rr_latency(rr_latency(:, end) >0.00, :);
rr_latency = rr_latency(rr_latency(:, end) <1, :);
re_latency = re_latency(re_latency(:, end) >0.00, :);
re_latency = re_latency(re_latency(:, end) <1, :);
sp_latency = sp_latency(sp_latency(:, end) >0.00, :);
sp_latency = sp_latency(sp_latency(:, end) <  .1, :);
rbs_latency = rbs_latency(rbs_latency(:, end) >0.00, :);
rbs_latency = rbs_latency(rbs_latency(:, end) <2, :);
end
function[]=plotpdf(lrtt_latency,rr_latency,re_latency,sp_latency)
global RTT exp_name;
figure 
ksdensity(lrtt_latency/RTT,'npoints',10000);
hold on;
ksdensity(rr_latency/RTT,'npoints',10000);
hold on;
ksdensity(re_latency/RTT,'npoints',10000);
hold on;
ksdensity(sp_latency/RTT,'npoints',10000);
title(strcat('PDF-',exp_name));
legend('LowRTT','RR','Redundant','SP');

% figure 
% histogram(lrtt_latency/RTT,10000,'Normalization','probability');
% hold on;
% histogram(rr_latency/RTT,10000,'Normalization','probability');
% hold on;
% histogram(re_latency/RTT,10000,'Normalization','probability');
% hold on;
% histogram(sp_latency/RTT,10000,'Normalization','probability');
% legend('LowRTT','RR','Redundant','SP');
end

function[]=plotcdf(lrtt_latency,rr_latency,re_latency,sp_latency)
global RTT exp_name;
figure 
cdfplot(lrtt_latency/RTT);
hold on;
cdfplot(rr_latency/RTT);
hold on;
cdfplot(re_latency/RTT);
hold on;
cdfplot(sp_latency/RTT);
title(strcat('CDF-',exp_name));
legend('LowRTT','RR','Redundant','SP');
end

function[]=plotsubflows(latency_dat)
global RTT;
subflow1 = latency_dat(~ismember(latency_dat(:,2),[167838210]),:);
subflow2 = latency_dat(~ismember(latency_dat(:,2),[167838466]),:);
% figure
% ksdensity(subflow1(:,10)/RTT,'npoints',10000);
% hold on;
% ksdensity(subflow2(:,10)/RTT,'npoints',10000);
figure;
scatter(subflow1(:,1),subflow1(:,6),'MarkerEdgeColor','blue');
hold on;
scatter(subflow1(:,1),subflow1(:,7),'MarkerEdgeColor','green');
hold on;
scatter(subflow2(:,1),subflow2(:,6),'MarkerEdgeColor','cyan');
hold on;
scatter(subflow2(:,1),subflow2(:,7),'MarkerEdgeColor','red');
legend('subflow1-send','subflow1-recv','subflow2-send','subflow2-recv');

end

