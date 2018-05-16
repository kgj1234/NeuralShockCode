%Deprecated

function []=PlotFilteredActivity(neural_activity,neurons,filterthreshold,shockboxstart,shockstart,shockend,shockboxend)


%Eliminate firing spikes that are too small



for i=1:length(neural_activity(:,1))
    current_std_fire=std(neural_activity(i,:));
    
    for j=1:length(neural_activity(1,:))
        if neural_activity(i,j)<filterthreshold*current_std_fire
            neural_activity(i,j)=0;
        end
    end
end
len=length(neurons);
x=linspace(0,length(neural_activity(1,:)),length(neural_activity(1,:)));
for i=1:len
    subplot(len,1,i)
    hold on
    plot(x,neural_activity(neurons(i),:))
   
    hold off
    xticks([0+4,shockboxstart+4,shockboxend+4,shockstart+4,shockend+4])
    xticklabels({'controlbox','shockbox','shockboxend','shock'})
end
