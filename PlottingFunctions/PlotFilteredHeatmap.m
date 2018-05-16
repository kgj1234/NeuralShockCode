function []=PlotFilteredHeatmap(neural_activity,neurons,filterthreshold,shockboxstart,shockstart,shockend,normalize)
%Gives heatmap of neural activity across single day
%neural_activity-S,C_raw,trace,firing_rate,etc
%neurons-vector containing which neurons to plot, ex [1,5,7,9,13,15]
%filterthreshold-float. activity less than the standard deviation of the
%activity multiplied by this number will be excluded
%shockboxstart,shockstart,shockend-integers

%normalize-boolean indicating whether to normalize data by max value

if normalize==true
    max_activity=max(neural_activity,[],2);
    neural_activity=neural_activity./max_activity;
end    

%Eliminate firing spikes that are too small and scale data
for i=1:length(neural_activity(:,1))
    
    current_std=std(neural_activity(i,:));
    for j=1:length(neural_activity(1,:))
        if neural_activity(i,j)<filterthreshold*current_std
            neural_activity(i,j)=0;
        end
    end
end


colormap(flipud(hot));
imagesc(neural_activity(neurons,:));
colorbar;
yticks(1:length(neurons));
yticklabels(neurons);
xticks([0+4,shockboxstart+4,shockstart+4,shockend+4]);
xticklabels({'bigbox','shockbox','shock'});



