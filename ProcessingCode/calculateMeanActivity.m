function mean_activity=calculateMeanActivity(neural_activity)


mean_activity=mean(neural_activity,2);
for i=1:length(mean_activity)
    if isnan(mean_activity(i))
        mean_activity(i)=0;
    end
end
        