k=1;
n=1;
global RTT;
RTT=1;
global TIME_RESOLUTION;
TIME_RESOLUTION = 1;
set(0,'DefaultFigureWindowStyle','docked');
set(0,'DefaultLineLineWidth',1.5);
% rr_dat =cell2mat(loadjson('roundrobin-interupted-data.json')); 
% re_dat=cell2mat(loadjson('redundant-interupted-data.json')); 
% rr_latency =[rr_dat.arrival_time].' -  [rr_dat.departure_time].'; 
% re_latency =[re_dat.arrival_time].' -  [re_dat.departure_time].';
prefix='D:\Data\mid-throughput\';
distribution_name = 'on5-off3';
global exp_name;
exp_name = 'dag-ditg-loss0.01-3mbps';
lrtt_latency=[];
rr_latency=[];
re_latency=[];
sp_latency=[];
rbs_latency=[];

for i=k:n
    lrtt_dat = csvread(strcat(prefix,exp_name,'-lowrtt-',num2str(i), '.dat' ));
    re_dat = csvread(strcat(prefix,exp_name,'-re-', num2str(i), '.dat' ));
    rr_dat = csvread(strcat(prefix,exp_name,'-opp-', num2str(i), '.dat' ));
    sp_dat = csvread(strcat(prefix,exp_name,'-lazytail-', num2str(i), '.dat' ));
    rbs_dat = csvread(strcat(prefix,exp_name,'-monkey-8-', num2str(i), '.dat' ));
    lrtt_latency=vertcat(lrtt_latency,lrtt_dat(50:end-50,10));
    rr_latency=vertcat(rr_latency,rr_dat(50:end-50,10));
    re_latency=vertcat(re_latency,re_dat(50:end-50,10));
    sp_latency=vertcat(sp_latency,sp_dat(50:end-50,10));
    rbs_latency=vertcat(rbs_latency,rbs_dat(50:end-50,10));
end
%[lrtt_latency,rr_latency,re_latency,sp_latency,rbs_latency]=filterdata(lrtt_latency,rr_latency,re_latency,sp_latency,rbs_latency);
% plotcdf(lrtt_latency,rr_latency,re_latency,sp_latency);
% plotpdf(lrtt_latency,rr_latency,re_latency,sp_latency);

plotccdf(lrtt_latency,re_latency,rr_latency,sp_latency,rbs_latency);
% redundant_thoughput = get_throughput(re_dat);
% lrtt_thoughput = get_throughput(lrtt_dat);
% rr_thoughput = get_throughput(rr_dat);
% sp_thoughput = get_throughput(sp_dat);
% rbs_thoughput = get_throughput(rbs_dat);
% figure
% plot(lrtt_thoughput);
% hold on;
% plot(redundant_thoughput);
% hold on;
% plot(rr_thoughput);
% hold on;
% plot(sp_thoughput);
% hold on;
% plot(rbs_thoughput);
% legend('LowRTT','RE','Tag1','Tag4','OPP'); 
target_dat=re_dat;
subflow1 = target_dat(~ismember(target_dat(:,2),[167838210]),:);
subflow2 = target_dat(~ismember(target_dat(:,2),[167838466]),:);

s1_thoughput = get_throughput(subflow1);
s2_thoughput = get_throughput(subflow2);
% 
% total_thoughput=get_throughput(target_dat);
% lrtt_thoughput=get_throughput(lrtt_dat);
% re_thoughput=get_throughput(re_dat);
% sp_thoughput=get_throughput(sp_dat); 
figure
plot(s1_thoughput(:,1), s1_thoughput(:,2));
hold on;
plot(s2_thoughput(:,1), s2_thoughput(:,2));
hold on;
% 
% figure
% plot(lrtt_thoughput(:,1), lrtt_thoughput(:,2));
% hold on;
% plot(re_thoughput(:,1), re_thoughput(:,2));
% hold on;
% plot(sp_thoughput(:,1), sp_thoughput(:,2));
% legend('LRTT','RE','MK');

lrtt_thoughput=get_throughput(lrtt_dat);
re_thoughput=get_throughput(re_dat);
mk_thoughput=get_throughput(sp_dat);
newmk_thoughput=get_throughput(rr_dat);
group = [    ones(size(lrtt_thoughput));
         2 * ones(size(re_thoughput));
         3 * ones(size(mk_thoughput));
         4 * ones(size(newmk_thoughput))];
figure
boxplot([lrtt_thoughput(:,2);re_thoughput(:,2);mk_thoughput(:,2);newmk_thoughput(:,2)],group);
set(gca,'XTickLabel',{'LRTT','RE','MK','OPP'});

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
    legend('LowRTT','OPP','RE','lazytail','Tag-8');   
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

function[thoughput]=get_throughput(sched_dat)
global TIME_RESOLUTION;
start_point = sched_dat(1,7);
end_point=sched_dat(end,7) ;
time_window= end_point - start_point;
thoughput = zeros(ceil(time_window)/TIME_RESOLUTION,2);

for i=1:size(thoughput)
    thoughput(i,1) = (start_point + i*ceil(time_window)/TIME_RESOLUTION);
end

for i=1:size(sched_dat)
    relative_time = (sched_dat(i,7) - start_point)/TIME_RESOLUTION;
    thoughput(floor(relative_time)+1,2) = thoughput(floor(relative_time)+1,2)+ sched_dat(i,11)*8;
end

thoughput = thoughput(20:end-20,:);
end

