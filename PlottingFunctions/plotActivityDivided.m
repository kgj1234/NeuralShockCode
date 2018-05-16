%There is almost no reason why this function should be used.


function plotActivityDivided(neural_activity,shockboxstart,shockstart,normalize)
%neural_activity-firing_rate,S,C,trace,etc
%shockboxstart,shockstart-integers indicating when the mouse is put in the
%shockbox, and when the shock starts. 



%normalize-boolean indicating whether to normalize data by max value

if normalize==true
    max_activity=max(neural_activity,[],2);
    neural_activity=neural_activity./max_activity;
end





height=max(max(neural_activity))+10;
time=linspace(0,66*length(neural_activity),length(neural_activity));
N=length(neural_activity(:,1));
col=flipud(winter(N));
set(gca, 'ColorOrder', col, 'NextPlot', 'replacechildren');
plot(time,neural_activity)
hold on
plot([shockboxstart*66,66*shockboxstart],[0,height],'black')
%plot([66*shockperstart,66*shockperstart],[0,height],'black')

plot([shockstart*66,66*shockstart],[0,height],'black')
%plot([shockend*66,66*shockend],[0,height],'red')
%plot([shockperend*66,66*shockperend],[0,height],'black')

hold off
xticks([66*floor(.5*shockboxstart),66*floor(.5*(shockboxstart+shockstart)),66*shockstart,66*floor(.5*(length(time)+shockstart))])
xticklabels({'Control Box','Pre-Shock','Shock','Post-Shock'})
axis([0,time(end),0,height])