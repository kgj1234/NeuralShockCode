function []=PlotActivity(neural_activity,indexon,indexoff,cutoff,shockstart,shockend,normalize)
%single experiment code
%Plots neural_activity from time indexon to time indexoff,
%thresholded by cutoff. 

%indexon,indexoff,shockstart,shockend-integers
%normalize-boolean to indicate whether to normalize data by max activity
%neural_activity-firing_rate,S,C,num_neurons by num_time_points matrix

%If no cutoff is desired, cutoff=0
%If no shock occurs, shockstart,shockend=0


%normalize-boolean indicating whether to normalize data by max value

if normalize==true
    max_activity=max(neural_activity,[],2);
    neural_activity=neural_activity./max_activity;
end


len=indexoff-indexon+1;
time=linspace(0,len*66,len);
figure()
if cutoff>0
    plot(time,neural_activity(max(transpose(neural_activity))>cutoff,indexon:indexoff))
else
    plot(time,neural_activity(:,indexon:indexoff))
end
hold on

if shockstart>0
    plot([(shockstart-indexon+1)*66,(shockstart-indexon+1)*66],[0,max(max(neural_activity))],'black','LineWidth',1.5)
    plot([(shockend-indexon+1)*66,(shockend-indexon+1)*66],[0,max(max(neural_activity))],'black','LineWidth',1.5)
end
axis([0,length(time)*66,0,max(max(neural_activity))])
hold off
