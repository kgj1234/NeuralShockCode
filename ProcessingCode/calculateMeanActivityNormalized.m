function mean_activity=calculateMeanActivityNormalized(neural_activity)

for i=1:length(neural_activity(:,1))
   
    if max(neural_activity(i,:)>0)
        neural_activity(i,:)=neural_activity(i,:)/max(neural_activity(i,:));
    else
        neural_activity(i,:)=0;
    end
end
mean_activity=mean(neural_activity,2);
for i=1:length(mean_activity);
    if isnan(mean_activity(i))
        mean_activity(i)=0;
    end
end
        