%=========================== SET PARAMS ===================================
k=1;
n=1;
prefix='D:\Data\conceal-1link\';
distribution_name = 'on5-off3';
global exp_name;
exp_name = 'conceal-ditg';

global RTT; RTT=1;
global TIME_RESOLUTION; TIME_RESOLUTION = 1;

set(0,'DefaultFigureWindowStyle','docked');
set(0,'DefaultLineLineWidth',1.5);

%=========================== IMPORT DATA ==================================

% rr_dat =cell2mat(loadjson('roundrobin-interupted-data.json')); 
% re_dat=cell2mat(loadjson('redundant-interupted-data.json')); 
% rr_latency =[rr_dat.arrival_time].' -  [rr_dat.departure_time].'; 
% re_latency =[re_dat.arrival_time].' -  [re_dat.departure_time].';

lrtt_latency=[];
rr_latency=[];
re_latency=[];
sp_latency=[];
rbs_latency=[];

labels=[];
for i=k:n
    lrtt_dat = csvread(strcat(prefix,exp_name,'-lowrtt-',num2str(i), '.dat' ));
    lrtt_latency = vertcat(lrtt_latency,lrtt_dat(50:end-50,10));
    labels=[labels, "LowRTT"];
    
    re_dat = csvread(strcat(prefix,exp_name,'-re-', num2str(i), '.dat' ));
    re_latency = vertcat(re_latency,re_dat(50:end-50,10));
    labels=[labels, "Redundant"];
    
    rr_dat = csvread(strcat(prefix,exp_name,'-rr-', num2str(i), '.dat' ));
    rr_latency = vertcat(rr_latency,rr_dat(50:end-50,10));
    labels=[labels, "RR"];
    
end

%============================= PLOTS ======================================

plotccdf(labels,lrtt_latency,re_latency,rr_latency);
plot_throughput(labels,lrtt_dat,re_dat,rr_dat);

% plot_subflows(lrtt_dat);
% plot_subflows(rr_dat);
% plot_subflows(re_dat);

%================================= END ====================================


function[]= filterdata(varargin)
    for i=1:nargin
        varargin = varargin(varargin(:, end) >0.00, :);
        varargin = varargin(varargin(:, end) <1, :);
    end
end

function[]=plotccdf(labels,varargin)
    global exp_name;
    
    figure
    for i=1:nargin-1
        [xccdf,yccdf]=getccdf(varargin{i});
        plot(xccdf,yccdf);
        hold on;
    end
    title(strcat('CCDF-',exp_name));
    legend(labels);
    set(gca, 'YScale', 'log');
end

function[xccdf,yccdf] = getccdf(value)
    [ycdf,xcdf] = cdfcalc(value);
    xccdf = xcdf;
    yccdf = 1-ycdf(1:end-1);
   
end

function[]=plotcdf(labels,varargin)
global exp_name;
figure
for i=1:nargin-1
    cdfplot(varargin{i});
    hold on;
end
title(strcat('CCDF-',exp_name));
legend(labels);   
set(gca, 'YScale', 'log');
end

function[]=plotsubflows(latency_dat)
    global RTT;
    subflow1 = latency_dat(~ismember(latency_dat(:,2),[167838210]),:);
    subflow2 = latency_dat(~ismember(latency_dat(:,2),[167838466]),:);
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

function[] = plot_throughput(labels,varargin)
    throughputs=[];
    group = [];
    for i=1:nargin-1
        thoughput=get_throughput(varargin{i});
        throughputs=[throughputs;thoughput(:,2)];
        group=[group;i*ones(size(thoughput(:,2)))];
    end
    
    figure
    boxplot(throughputs,group);
    set(gca,'XTickLabel',labels);
end

function[] = plot_subflows(flow_data)
    [sf_group,sf_senders] = findgroups(flow_data(:,2));
    sf_throughput = splitapply(@(x){(get_throughput(x))},flow_data,sf_group);
    figure
    for i=1:size(sf_throughput(:,1))
        plot(sf_throughput{i,1}(:,1), sf_throughput{i,1}(:,2));
        hold on;
    end
    legend(dec2ip(sf_senders));
    
end

function[ip] = dec2ip(decip)
    ip= strcat( num2str(bitand(bitshift(decip,-24), 255)) ,'.', num2str(bitand(bitshift(decip,-16), 255)) ,'.', num2str(bitand(bitshift(decip,-8), 255))  ,'.', num2str(bitand(bitshift(decip,0), 255)));  
end

