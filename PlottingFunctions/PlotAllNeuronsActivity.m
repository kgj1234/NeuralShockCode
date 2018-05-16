function []=PlotAllNeuronsActivity(neural_activity,shockboxstart,shockstart,num_per_group,normalize)
%neural_activity-trace,C,S,etc.
%shockboxstart will generally be a field inside the neuron
%shockstart will generally be a field inside the neuron
%num_per_group tells how many neurons to plot in each figure

%normalize-boolean indicating whether to normalize data by max value

if normalize==true
    max_activity=max(neural_activity,[],2);
    neural_activity=neural_activity./max_activity;
end

for i=1:floor(length(neural_activity(:,1))/num_per_group)
    figure()
    plotTracesDivided(neural_activity((num_per_group)*(i-1)+1:num_per_group*i,:),shockboxstart,shockstart)
end

if mod(length(neural_activity(:,1)),num_per_group)~=0
    figure()
    plotTracesDivided(neural_activity(end-mod(length(neural_activity(:,1)),num_per_group):end,:),shockboxstart,shockstart)
end
