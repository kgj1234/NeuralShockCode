function num_exceeding=numExceedingThreshold(neural_activity,time_vector,threshold)
%Calculates the percentage of time a neuron is active, such that its
%activity is over some value threshold, with threshold between 0 and 1.
%time vector-the vector of time points over which the above is to be
%calculated.
for i=1:length(neural_activity(:,1))
    neural_activity(i,:)=neural_activity(i,:)/max(neural_activity(i,:));
end
for i=1:length(neural_activity(:,1))
    num_exceeding(i)=sum(neural_activity(i,time_vector)>threshold);
    num_exceeding(i)=num_exceeding(i)/sum(neural_activity(i,time_vector)>0)*100;
end