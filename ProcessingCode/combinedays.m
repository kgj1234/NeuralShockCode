function combinedneuron=combinedays(neuronIndividuals,filename)
%Combine neurons into 1 datafile
%Requires 3 experiments per day

combinedneuron.S=[];
combinedneuron.C=[];
combinedneuron.position=[];
combinedneuron.positionblue=[];
combinedneuron.trace=[];
combinedneuron.trace_raw=[];
combinedneuron.firing_rate=[];
%Since we are only using some fields, including some with unique properties,
%we iterate through those fields. More fields can be added later as
%necessary


for i=1:length(neuronIndividuals)
    combinedneuron.S=horzcat(combinedneuron.S,neuronIndividuals{1,i}.S);
    combinedneuron.C=horzcat(combinedneuron.C,neuronIndividuals{1,i}.C);
    combinedneuron.position=vertcat(combinedneuron.position,neuronIndividuals{1,i}.position);
    combinedneuron.positionblue=vertcat(combinedneuron.positionblue, neuronIndividuals{1,i}.positionblue);
    combinedneuron.trace=horzcat(combinedneuron.trace,neuronIndividuals{1,i}.trace );
    combinedneuron.trace_raw=horzcat(combinedneuron.trace_raw,neuronIndividuals{1,i}.trace_raw );
    combinedneuron.firing_rate=horzcat(combinedneuron.firing_rate,neuronIndividuals{1,i}.firing_rate);
end
combinedneuron.time=neuronIndividuals{1,1}.time;

combinedneuron.BigBoxBeg=[1];
combinedneuron.ShockBoxBeg=[];
combinedneuron.ShockExpBeg=[];
combinedneuron.shockstart=[];
combinedneuron.shockend=[];
for j=2:length(neuronIndividuals)


    if mod(j,3)==1
        combinedneuron.BigBoxBeg=[combinedneuron.BigBoxBeg,length(combinedneuron.time)+1];
    elseif mod(j,3)==2
        combinedneuron.ShockBoxBeg=[combinedneuron.ShockBoxBeg,length(combinedneuron.time)+1];
    elseif mod(j,3)==0
        
        combinedneuron.ShockExpBeg=[combinedneuron.ShockExpBeg,length(combinedneuron.time)+1];
        combinedneuron.shockstart=[combinedneuron.shockstart,length(combinedneuron.time)+1+neuronIndividuals{1,j}.shockstart];
        combinedneuron.shockend=[combinedneuron.shockend,length(combinedneuron.time)+1+neuronIndividuals{1,j}.shockend];
    end
    avg_time_diff=mean(neuronIndividuals{1,j-1}.time(2:end)-neuronIndividuals{1,j-1}.time(1:end-1));
    combinedneuron.time=vertcat(combinedneuron.time,combinedneuron.time(end)+avg_time_diff+neuronIndividuals{1,j}.time);
end
combinedneuron.centroid=neuronIndividuals{1,1}.centroid;





    



save(filename,'combinedneuron')