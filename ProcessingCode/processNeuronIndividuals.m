function neuronIndividuals=processNeuronIndividuals(neuronIndividuals)
%shockstart-vector 1/3 the length of neuronIndividuals containing the frame
%at which shock starts for each experiment
%shockend-similar to shockend but containing the end frame
%behavpaths-vector of paths to files containing neuron behavior. Should
%have same length as neuronIndividuals
calculategaussianfiringratefromS(neuronIndividuals,5,20);
behavpaths;
shockstart=[];
shockend=[];
for i=1:length(neuronIndividuals)/3
    disp(i)
    [first,last]=calculateshocktime
    shockstart=[shockstart,first];
    shockend=[shockend,last];
end
%shockstart=[126   295   240   210   250   242   331   264   194];
%shockend=[211   345   287   259   301   283   370   318   242];
%behav_paths{3}
for i=1:length(neuronIndividuals)
    behav=load(behav_paths{i});
    behav=behav.behav;
    alignposition(neuronIndividuals{1,i},behav)
    if mod(i,3)==0
        neuronIndividuals{1,i}.shockstart=shockstart(i/3);
        neuronIndividuals{1,i}.shockend=shockend(i/3);
    end
end
