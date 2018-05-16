function []=PlotMeanActivity(neural_activity,timeon,timeoff,shockstart,shockend)
%Plots mean neural activity over interval timeon:timeoff
%neural_activity-trace,firing_rate,etc
%timeon,timeoff,shockstart,shockedn-integers
%if no shock occurs in the interval, set shockstart,shockend=0



time=linspace(0,(timeoff-timeon+1)*66,(timeoff-timeon+1)*66);
plot(time,mean(neural_activity(:,timeon:timeoff)))
hold on
if shockstart>0
    plot([(shockstart-timeon+1)*66,(shockstart-timeon+1)*66],[0,max(mean(neural_activity(:,timeon:timeoff)))],'black')
    plot([(shockend-timeon+1)*66,(shockend-timeon+1)*66],[0,max(mean(neural_activity(:,timeon:timeoff)))],'black')
end    
hold off
axis([0,(timeoff-timeon+1)*66,0,max(mean(neural_activity(:,timeon:timeoff)))])
