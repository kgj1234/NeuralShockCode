function mean_positive_activity=calculateMeanPositiveActivityNormalized(neural_activity)

for i=1:length(neural_activity(:,1))
   
    if max(neural_activity(i,:)>0)
        neural_activity(i,:)=neural_activity(i,:)/max(neural_activity(i,:));
    else
        neural_activity(i,:)=0;
    end
end

for i=1:size(neural_activity,1)
    total=0;
    activity=0;
    for j=1:size(neural_activity,2)
        if neural_activity(i,j)>0
            total=total+1;
            activity=activity+neural_activity(i,j);
        end
    if total>0
        mean_positive_activity(i)=activity/total; 
    else
        mean_positive_activity(i)=0;
    end
    
    end
    
    
end