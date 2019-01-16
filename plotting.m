%=========================== SET PARAMS ===================================
k=1;
n=1;
prefix='D:\Data\new-monkey-varpsize\';
distribution_name = 'on5-off3';
global exp_name;
exp_name = 'conceal-ditg';

global RTT; RTT=1;
global TIME_RESOLUTION; TIME_RESOLUTION = .1;

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
opp_latency=[];
tag8_latency=[];
lazytail_0_latency=[];
newmonkey1_latency=[];
newmonkey50_latency=[];
newmonkey100_latency=[];
newmonkey20_latency=[];


labels=[];
for i=k:n
    lrtt_dat = csvread(strcat(prefix,exp_name,'-lowrtt-',num2str(i), '.dat' ));
    lrtt_latency = vertcat(lrtt_latency,lrtt_dat(50:end-50,10));
    labels=[labels, "LowRTT"];
    
    
    re_dat = csvread(strcat(prefix,exp_name,'-re-', num2str(i), '.dat' ));
    re_latency = vertcat(re_latency,re_dat(50:end-50,10));
    labels=[labels, "Redundant"];
%     
%     rr_dat = csvread(strcat(prefix,exp_name,'-rr-', num2str(i), '.dat' ));
%     rr_latency = vertcat(rr_latency,rr_dat(50:end-50,10));
%     labels=[labels, "RR"];
    
    opp_dat = csvread(strcat(prefix,exp_name,'-opp-', num2str(i), '.dat' ));
    opp_latency = vertcat(opp_latency,opp_dat(50:end-50,10));
    labels=[labels, "opp"];
    
%     tag8_dat = csvread(strcat(prefix,exp_name,'-tag-8-', num2str(i), '.dat' ));
%     tag8_latency = vertcat(tag8_latency,tag8_dat(50:end-50,10));
%     labels=[labels, "tag8"];
    
    lazytail_0_dat = csvread(strcat(prefix,exp_name,'-lazytail-0-', num2str(i), '.dat' ));
    lazytail_0_latency = vertcat(lazytail_0_latency,lazytail_0_dat(50:end-50,10));
    labels=[labels, "lazy-0"];
    
%     newmonkey1_dat = csvread(strcat(prefix,exp_name,'-newmonkey-1-', num2str(i), '.dat' ));
%     newmonkey1_latency = vertcat(newmonkey1_latency,newmonkey1_dat(50:end-50,10));
%     labels=[labels, "new-monkey-1"];
    
    newmonkey50_dat = csvread(strcat(prefix,exp_name,'-newmonkey-20-', num2str(i), '.dat' ));
    newmonkey50_latency = vertcat(newmonkey50_latency,newmonkey50_dat(50:end-50,10));
    labels=[labels, "new-monkey-20"];    
    
    newmonkey100_dat = csvread(strcat(prefix,exp_name,'-newmonkey-40-', num2str(i), '.dat' ));
    newmonkey100_latency = vertcat(newmonkey100_latency,newmonkey100_dat(50:end-50,10));
    labels=[labels, "new-monkey-40"];    
    
    newmonkey20_dat = csvread(strcat(prefix,exp_name,'-newmonkey-70-', num2str(i), '.dat' ));
    newmonkey20_latency = vertcat(newmonkey20_latency,newmonkey20_dat(50:end-50,10));
    labels=[labels, "new-monkey-70"];    
       
end

%============================= PLOTS ======================================
% [lrtt_latency,re_latency,opp_latency ,tag0_latency,tag8_latency] = filterdata(lrtt_latency,re_latency,opp_latency ,tag0_latency,tag8_latency);
% plotccdf(labels,monkey0_latency,monkey2_latency,monkey4_latency,monkey8_latency,monkey16_latency);
% [lrtt_latency, re_latency, opp_latency , lazytail_0_latency,newmonkey50_latency,newmonkey100_latency,newmonkey20_latency] = filterdata(lrtt_latency, re_latency, opp_latency , lazytail_0_latency,newmonkey50_latency,newmonkey100_latency,newmonkey20_latency);
% plotccdf(labels, lrtt_latency, re_latency, opp_latency , lazytail_0_latency,newmonkey50_latency);
% [monkey0_1_latency,monkey2_1_latency,monkey2_2_latency,monkey4_1_latency,monkey4_4_latency,monkey8_1_latency,monkey8_4_latency,monkey8_8_latency,monkey16_1_latency,monkey16_4_latency,monkey16_8_latency]=filterdata(monkey0_1_latency,monkey2_1_latency,monkey2_2_latency,monkey4_1_latency,monkey4_4_latency,monkey8_1_latency,monkey8_4_latency,monkey8_8_latency,monkey16_1_latency,monkey16_4_latency,monkey16_8_latency);
% plotccdf(labels,lrtt_latency,re_latency,monkey0_1_latency,monkey2_1_latency,monkey2_2_latency,monkey4_1_latency,monkey4_4_latency,monkey8_1_latency,monkey8_4_latency,monkey8_8_latency,monkey16_1_latency,monkey16_4_latency,monkey16_8_latency);
% plot_ref();
% plot_avg_latency(labels, lrtt_latency, re_latency, opp_latency , lazytail_0_latency,newmonkey50_latency);

plot_quantile(0.05,labels, lrtt_latency, re_latency, opp_latency , lazytail_0_latency,newmonkey50_latency,newmonkey100_latency,newmonkey20_latency);

% plotpdf(labels,lrtt_latency,re_latency,opp_latency ,tag0_latency,tag8_latency);
% plot_throughput(labels,lrtt_dat, re_dat, opp_dat , tag8_dat, lazytail_8_dat, newmonkey1_dat);
% boxplot_latency(labels,lrtt_latency,re_latency,opp_latency ,tag0_latency, monkey8_latency,monkey7_latency);
% plot_subflows(rr_dat);
% plot_subflows("LowRTT",lrtt_dat);
% plot_subflows("Redundant",re_dat);
% plot_subflows("tag0",tag0_dat);
% plot_subflows("TAG8",tag8_dat);
% plot_subflows("newmk1",newmonkey1_dat);

%================================= END ====================================


function []= plot_ref()
    x1=50/1000;
    line([x1 x1], get(gca, 'ylim'),'LineWidth',2, 'LineStyle','--','Color','Red','HandleVisibility','off');
    
    
%     x2=40/1000;
%     line([x2 x2], get(gca, 'ylim'),'LineWidth',2, 'LineStyle','--','Color','Red','HandleVisibility','off');
%     
%     x3=70/1000;
%     line([x3 x3], get(gca, 'ylim'),'LineWidth',2, 'LineStyle','--','Color','Red','HandleVisibility','off');
%     y1=.1/100;
%     line(get(gca, 'xlim'),[y1 y1],'LineWidth',2, 'LineStyle','-.','Color','Red','HandleVisibility','off');   
end

function [varargout]= filterdata(varargin)
    for i=1:nargin
        varargout{i} = varargin{i}(varargin{i}(:, 1) > 0, :);
        varargout{i} = varargout{i}(varargout{i}(:, 1) < 0.15, :);
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
    xlabel('Latency (seconds)') ;
    ylabel('Probability P(X>x)');
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
    TIME_COLUMM = 7;
    start_point = sched_dat(1,TIME_COLUMM);
    end_point=sched_dat(end,TIME_COLUMM) ;
    time_window= end_point - start_point;
    thoughput = zeros(ceil(time_window)/TIME_RESOLUTION,2);
    
    for i=1:size(thoughput)
        thoughput(i,1) = (i*TIME_RESOLUTION);

    end

    for i=1:size(sched_dat)
        relative_time = (sched_dat(i,TIME_COLUMM) - start_point)/TIME_RESOLUTION;
        thoughput(floor(relative_time)+1,2) = thoughput(floor(relative_time)+1,2)+ sched_dat(i,11)*8/TIME_RESOLUTION;
    end
    
    % trim the results
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

function[] = boxplot_latency(labels,varargin)
    latencies=[];
    group = [];
    for i=1:nargin-1
      
        latencies=[latencies;varargin{i}];
        group=[group;i*ones(size(varargin{i}))];
    end
    
    figure
    boxplot(latencies,group);
    set(gca,'XTickLabel',labels);
end

function[] = plot_subflows(plot_title,flow_data)
    
    [sf_group,sf_senders] = findgroups(flow_data(:,2));
    sf_throughput = splitapply(@(x){(get_throughput(x))},flow_data,sf_group);
    figure
    for i=1:size(sf_throughput(:,1))
        plot(sf_throughput{i,1}(:,1), sf_throughput{i,1}(:,2));
        hold on;
    end
    legend(dec2ip(sf_senders));
    
%     flow_throughput=get_throughput(flow_data);
%     plot(flow_throughput(:,1), flow_throughput(:,2));
%     hold on;
%     legend("All");


     title(plot_title);
    
end



function[ip] = dec2ip(decip)
    ip= strcat( num2str(bitand(bitshift(decip,-24), 255)) ,'.', num2str(bitand(bitshift(decip,-16), 255)) ,'.', num2str(bitand(bitshift(decip,-8), 255))  ,'.', num2str(bitand(bitshift(decip,0), 255)));  
end

function[] = plotpdf(labels, varargin)
    global exp_name;
    figure
    for i=1:nargin-1
        [fi,xi] = ksdensity(varargin{i});
        plot(xi,fi);
        hold on;
    end
    title(strcat('PDF-',exp_name));
    legend(labels);
%     set(gca, 'YScale', 'log');
end

function[] = plot_avg_latency(labels, varargin)
    global exp_name;
    bar_data=[];
    
    for i=1:nargin-1
        bar_data = [bar_data, mean(varargin{i})];
        hold on;
    end
    figure
    bar(categorical(labels),bar_data);
    title(strcat('avg-delay-',exp_name));
    

end

function[] = plot_quantile(bound, labels, varargin)
    global exp_name;
    bar_data=[];
    
    for i=1:nargin-2
        temp = varargin{i}(varargin{i}(:, 1) < bound, :);
        bar_data = [bar_data, size(temp(:,1))/size(varargin{i}(:,1))];
        hold on;
    end
    figure
    bar(categorical(labels),bar_data);
    title(strcat('P(X<50)-',exp_name));
    
end
