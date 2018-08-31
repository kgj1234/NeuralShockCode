function []=PlotMeanActivityNew(neuronIndividuals,field)
%Plots Mean activity divided by experiment, across multiple days.
%each day must have 3 experiments. 

labels={'Big Box', 'Shock Box', 'Shock'};
figure('name',field)
  
for j=1:3
    s(j)=subplot(3,1,j);
    vector=[];
    for i=j:3:length(neuronIndividuals)
        activity=getfield(neuronIndividuals{1,i},field);
        vector=[vector,mean(activity)];
    end
    plot(1:length(vector),vector)
    ylabel(labels{j})
end

        
    
