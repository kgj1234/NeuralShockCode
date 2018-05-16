function []=PlotActivityAcrossDays(combinedneuron,activity_field,neuron_subset,normalize,thresh)
%Plots a heatmap of neural activity from a combined neuron. The combined
%neuron must have fields BigBoxBeg (vector containing the indices at which
%the BigBox experiments begin, ShockBoxBeg, ShockBeg,ShockEnd


%combinedneuron-A structure containing neural activity across multiple days
%activity_field-firing_rate,C,S,trace,etc.
%neuron_subset-vector that contains the neurons you desire to plot
%normalize-boolean indicating whether to normalize by max activity
%thresh-threshold for which neural activity under the threshold is excluded




neural_activity=getfield(combinedneuron,activity_field);
separation_times=[];
for i=1:length(combinedneuron.ShockBeg)
    separation_times=[separation_times,combinedneuron.BigBoxBeg(i)];
    separation_times=[separation_times,combinedneuron.ShockBoxBeg(i)];
    separation_times=[separation_times,combinedneuron.ShockBeg(i)];
    separation_times=[separation_times,combinedneuron.ShockEnd(i)];
end

labels=repmat(['Big','Shock','Beg','End'],length(combinedneuron.ShockBeg));
if normalize==true
    for i=1:size(neural_activity,1)
        if max(neural_activity(i,:))>0
            neural_activity(i,:)=neural_activity(i,:)/max(neural_activity(i,:));
        end
    end
end
if thresh>0&&normalize==true
    for i=1:size(neural_activity,1)
        for j=1:size(neural_activity,2)
            if neural_activity(i,j)<thresh
                neural_activity(i,j)=0;
            end
        end
    end
end
colormap(flipud(hot));
imagesc(neural_activity(neuron_subset,:));
colorbar;
yticks(1:length(neuron_subset));
yticklabels(neuron_subset);
xticks(separation_times+4);
%xticklabels(labels);
