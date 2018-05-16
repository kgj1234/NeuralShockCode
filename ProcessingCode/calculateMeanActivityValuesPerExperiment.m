function mean_values=calculateMeanActivityValuesPerExperiment(neuronIndividuals,activity,positive,normalized)
Results=[];
for i=1:length(neuronIndividuals)
    neural_activity=getfield(neuronIndividuals{i},activity);
  
    if mod(i,3)==0
        neural_activity=neural_activity(neuronIndividuals{i}.shockstart:neuronIndividuals{i}.shockend);
    end
    
    if positive==true
        if normalized==true
            Results=[Results,mean(calculateMeanPositiveActivityNormalized(neural_activity))];
        else
            Results=[Results,mean(calculateMeanPositiveActivity(neural_activity))];
        end
    else
        if normalized==true
            Results=[Results,mean(calculateMeanActivityNormalized(neural_activity))];
        else
            Results=[Results,mean(calculateMeanActivity(neural_activity))];
        end
    end
end

mean_values=reshape(Results,[3,length(neuronIndividuals)/3]);
            
            