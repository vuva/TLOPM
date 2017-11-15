n=5;
global RTT;
RTT=1;
set(0,'DefaultFigureWindowStyle','docked')
% rr_dat =cell2mat(loadjson('roundrobin-interupted-data.json')); 
% re_dat=cell2mat(loadjson('redundant-interupted-data.json')); 
% rr_latency =[rr_dat.arrival_time].' -  [rr_dat.departure_time].'; 
% re_latency =[re_dat.arrival_time].' -  [re_dat.departure_time].';
prefix='D:\Data\DAG-tcpdump';
distribution_name = 'on5-off3';
global exp_name;
exp_name = 'iperf-non-interupted';
lrtt_latency=[];
rr_latency=[];
re_latency=[];
sp_latency=[];

for i=1:n
    lrtt_dat = csvread(strcat(prefix,exp_name,'-lowrtt-',distribution_name, '-',num2str(i), '.dat' ));
    rr_dat = csvread(strcat(prefix,exp_name,'-rr-',distribution_name, '-', num2str(i), '.dat' ));
    re_dat = csvread(strcat(prefix,exp_name,'-re-',distribution_name, '-', num2str(i), '.dat' ));
    sp_dat = csvread(strcat(prefix,exp_name,'-re-',distribution_name, '-', num2str(i), '.dat' ));
    lrtt_latency=vertcat(lrtt_latency,lrtt_dat(:,10));
    rr_latency=vertcat(rr_latency,rr_dat(:,10));
    re_latency=vertcat(re_latency,re_dat(:,10));
    sp_latency=vertcat(sp_latency,sp_dat(:,10));
end
[lrtt_latency,rr_latency,re_latency,sp_latency]=filterdata(lrtt_latency,rr_latency,re_latency,sp_latency)
plotcdf(lrtt_latency,rr_latency,re_latency,sp_latency);
plotpdf(lrtt_latency,rr_latency,re_latency,sp_latency);
plotccdf(lrtt_latency,rr_latency,re_latency,sp_latency);

function[]=plotccdf(lrtt_latency,rr_latency,re_latency,sp_latency)
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
    title(strcat('CCDF-',exp_name));
    legend('LowRTT','RR','Redundant','SP');
end

function[xccdf,yccdf] = getccdf(value)
    [ycdf,xcdf] = cdfcalc(value);
    xccdf = xcdf;
    yccdf = 1-ycdf(1:end-1);
    plot(xccdf,yccdf);
end
function[lrtt_latency,rr_latency,re_latency,sp_latency]= filterdata(lrtt_latency,rr_latency,re_latency,sp_latency)
lrtt_latency = lrtt_latency(lrtt_latency(:, end) >=0.00, :);
lrtt_latency = lrtt_latency(lrtt_latency(:, end) <10, :);
rr_latency = rr_latency(rr_latency(:, end) >=0.00, :);
rr_latency = rr_latency(rr_latency(:, end) <10, :);
re_latency = re_latency(re_latency(:, end) >=0.00, :);
re_latency = re_latency(re_latency(:, end) <10, :);
sp_latency = sp_latency(sp_latency(:, end) >=0.00, :);
sp_latency = sp_latency(sp_latency(:, end) <10, :);
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
figure
ksdensity(subflow1(:,10)/RTT,'npoints',10000);
hold on;
ksdensity(subflow2(:,10)/RTT,'npoints',10000);
end