function []=ExtractIndividualDays(neuronIndividuals)
%Extracts neuronIndividuals into individual days. Requires 3 experiments
%per day
for i=1:length(neuronIndividuals)/3
    neuron=cell(1,3);
    indices=3*(i-1)+1:3*i;
    for j=1:length(indices)
        neuron{1,j}=neuronIndividuals{1,indices(j)};
    end
    combinedays(neuron,strcat('day',num2str(i)));
end