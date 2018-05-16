function y=shockActiveNeurons(neural_activity,indexon,indexoff,maxim,minim,normalize)
%neural_activity-trace,S,C,etc
%maxim-threshold neuron has to exceed on indexon:indexoff
%minim-threshold neuron cannot exceed prior to indexon
%normalize-boolean that indicates whether or not to normalize the data

%This is typically used to identify neurons that are active only near the
%time the animal is being shocked

if normalize==true
    max_activity=max(neural_activity,[],2);
    neural_activity=neural_activity./max_activity;
end


for i=1:length(neural_activity(:,1))
    if max(neural_activity(i,indexon:indexoff))>maxim&&max(neural_activity(i,1:indexon))<minim
        y=[y,i];
    end
end