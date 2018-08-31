function mean_positive_activity=calculateMeanPositiveActivity(neural_activity)
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