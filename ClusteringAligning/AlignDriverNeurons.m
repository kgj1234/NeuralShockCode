function [Trace,OrderedIndexList]=AlignDriverNeurons(neural_activity)
%Orders neurons by time at which max activity value occurs, then offsets
%activity data so as to line up the max values at 0





max_val_index=zeros(length(neural_activity(:,1)),2);
for i=1:length(neural_activity)
    max_val_index(i,1)=i;
    [M,I]=max(neural_activity(i,:));
    max_val_index(i,2)=I;
end
OrderedIndexList=sortrows(max_val_index,2);
AlignedTrace=zeros(length(neural_activity(:,1)),length(neural_activity(1,:)));


for i=1:length(neural_activity(:,1))
   
    AlignedTrace(i,1:end-max_val_index(i,2)+1)=neural_activity(i,max_val_index(i,2):end);
end
Trace=AlignedTrace;
   