% sampling rate
t = 1/pps;

if px2m ~= 0
    % displacement between frames
    dd = segLength/px2m;
else
    dd = segLength;
end
% velocity
v = dd/t;
% acceleration
dv = diff(v);
a = dv/t;

% smooth velocity and arousal over time
velKern = normpdf(velSmooth,0,1);
velKern = velKern/sum(velKern);
v = conv(v,velKern,'same');
a = conv(a,velKern,'same');
vt = 0:(pathTime/(length(v)-1)):pathTime;
at = 0:(pathTime/(length(a)-1)):pathTime;

% init fig
figure
hold on

% add color bar
for i = 1:nUse
    plot(i*t,0,'s','markerfacecolor',col(i,:),'markeredgecolor','none','markersize',10)
end

% plot velocity and acceleration
[ax,lv,la] = plotyy(vt,v,at,a);

% format lines
set(lv,'linewidth',1);
set(la,'linewidth',1);

% format axes
if px2m ~= 0
    dUnit = 'm';
else
    dUnit = '[px]';
end
set(get(ax(1),'ylabel'),'string',['Velocity (' dUnit 's^{-1})']);
set(get(ax(2),'ylabel'),'string',['Acceleration (' dUnit 's^{-2})']);
xlabel('Time (s)');
set(gcf,'PaperUnits','inches','PaperPosition',[0 0 8 2.5],'PaperSize',[8 2.5])

% scale down fig so not cut off
scalefactor = .90;
g = get(gca,'Position');
g(1:2) = g(1:2) + (1-scalefactor)/2*g(3:4);
g(3:4) = scalefactor*g(3:4);
set(gca,'Position',g);    

% save fig
print([path_out 'STLvel_' fname(1:(end-4)) '.pdf'],'-dpdf')
close

disp(sprintf('Velocity-acceleration plot generated ("%s")',['STLvel_' fname(1:(end-4)) '.pdf']))


% output some of the calculated values
out.velVel      = v;
out.velAcc      = a;
