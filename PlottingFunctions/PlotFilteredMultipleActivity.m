function []=PlotFilteredMultipleActivity(activity1,activity2,neurons,filterthreshold,shockboxstart,shockstart,shockend,shockboxend,normalize1,normalize2)
%activity1,activity2-sets of neural activity. Suggest activity1 S,
%activity2 C,firing_rate, or trace

%Plots two different kinds of neural activity in the same plot, for a
%subset of neurons.

%neurons-vector of which neurons to plot ex [1,5,7,8,9]
%filterthreshold-multiplier of standard deviation of neural activity used
%to filter spikes


%Eliminate firing spikes that are too small

%Only for activity1, this can be extended to activity2 if necessary

%normalize1-boolean indicating whether to normalize first data  by max value
%normalize2-similar
if normalize1==true
    max_activity=max(activity1,[],2);
    activity1=activity1./max_activity;
end

if normalize2==true
    max_activity=max(activity2,[],2);
    activity2=activity2./max_activity;
end




for i=1:length(activity1(:,1))
    current_std_fire=std(activity1(i,:));
    
    for j=1:length(activity1(1,:))
        if activity1(i,j)<filterthreshold*current_std_fire
            activity1(i,j)=0;
        end
    end
end
len=length(neurons);
x=linspace(0,length(activity1(1,:)),length(activity1(1,:)));
for i=1:len
    subplot(len,1,i)
    hold on
    plot(x,activity1(neurons(i),:))
    plot(x,activity2(neurons(i),:))
    hold off
    xticks([0+4,shockboxstart+4,shockboxend+4,shockstart+4,shockend+4])
    xticklabels({'controlbox','shockbox','shockboxend','shock'})
end

    