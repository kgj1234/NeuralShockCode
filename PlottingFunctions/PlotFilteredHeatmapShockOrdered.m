function []=PlotFilteredHeatmapShockOrdered(neural_activity,neurons,filterthreshold,shockboxstart,shockstart,shockend,normalize)
%Identical to PlotFilteredHeatmap, but orders neurons by max value during
%shock. This should have been added as an option to PlotFilteredHeatmap,
%but I'm lazy.


%normalize-boolean indicating whether to normalize data by max value

if normalize==true
    max_activity=max(neural_activity,[],2);
    neural_activity=neural_activity./max_activity;
end

%Eliminate firing spikes that are too small and scale data
for i=1:length(neural_activity(:,1))
   
    current_std=std(neural_activity(i,neural_activity(i,:)>0));
    for j=1:length(neural_activity(1,:))
        if neural_activity(i,j)<filterthreshold*current_std
            neural_activity(i,j)=0;
        end
    end
end
%Order by max spiking during shock
max_values=zeros(size(neural_activity,1),2);
max_values(:,1)=1:size(neural_activity,1);
max_values(:,2)=max(neural_activity(:,shockstart:shockend),[],2);
max_values=sortrows(max_values,2,'descend');
max_values
neural_activity=neural_activity(max_values(:,1),:);



colormap(flipud(hot));
imagesc(neural_activity(neurons,:));
colorbar;
yticks(1:length(neurons));
yticklabels(neurons);
xticks([0+4,shockboxstart+4,shockstart+4,shockend+4]);
xticklabels({'controlbox','shockbox','shock'});



