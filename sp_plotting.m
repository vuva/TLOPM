n=1;

set(0,'DefaultFigureWindowStyle','docked')

prefix='C:\Work\Data\dump-delay\';
sp_latency=[];
spdag_latency=[];

for i=1:n
    sp_dat = csvread(strcat(prefix,'dump-delay', '-',num2str(i), '.dat' ));
    spdag_dat = csvread(strcat(prefix,'dag-dump-delay', '-', num2str(i), '.dat' ));
    sp_latency=vertcat(sp_latency,sp_dat(:,10));
    spdag_latency=vertcat(spdag_latency,spdag_dat(:,10));

end
figure 
cdfplot(sp_latency);
hold on;
cdfplot(spdag_latency);

legend('dump','dag');

figure 
ksdensity(sp_latency,'npoints',10000);
hold on;
ksdensity(spdag_latency,'npoints',10000);

legend('dump','dag');


function[xccdf,yccdf] = plotccdf(value)
    [ycdf,xcdf] = cdfcalc(value);
    xccdf = xcdf;
    yccdf = 1-ycdf(1:end-1);
    plot(xccdf,yccdf);
end
function[]= filterdata(lrtt_latency,rr_latency,re_latency,sp_latency)
lrtt_latency = lrtt_latency(lrtt_latency(:, end) >=0.05, :);
lrtt_latency = lrtt_latency(lrtt_latency(:, end) <1, :);
rr_latency = rr_latency(rr_latency(:, end) >=0.05, :);
rr_latency = rr_latency(rr_latency(:, end) <1, :);
re_latency = re_latency(re_latency(:, end) >=0.05, :);
re_latency = re_latency(re_latency(:, end) <1, :);
end
function[]=plotpdf(lrtt_latency,rr_latency,re_latency,sp_latency)
global RTT;
figure 
ksdensity(lrtt_latency/RTT,'npoints',10000);
hold on;
ksdensity(rr_latency/RTT,'npoints',10000);
hold on;
ksdensity(re_latency/RTT,'npoints',10000);
hold on;
ksdensity(sp_latency/RTT,'npoints',10000);
legend('LowRTT','RR','Redundant','SP');

figure 
histogram(lrtt_latency/RTT,10000,'Normalization','probability');
hold on;
histogram(rr_latency/RTT,10000,'Normalization','probability');
hold on;
histogram(re_latency/RTT,10000,'Normalization','probability');
hold on;
histogram(sp_latency/RTT,10000,'Normalization','probability');
legend('LowRTT','RR','Redundant','SP');
end

function[]=plotcdf(lrtt_latency,rr_latency,re_latency,sp_latency)
global RTT;
figure 
cdfplot(lrtt_latency/RTT);
hold on;
cdfplot(rr_latency/RTT);
hold on;
cdfplot(re_latency/RTT);
hold on;
cdfplot(sp_latency/RTT);
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