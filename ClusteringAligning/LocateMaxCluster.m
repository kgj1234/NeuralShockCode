function [OrderedIndexList,clusters]=LocateMaxCluster(neural_activity,indexon,indexoff,cutoff,normalize, numclusters)
%This orders the neurons by the first time each neuron reaches its maximum
%firing rate in the time interval indexon:indexoff. It then
%determines the numclusters's largest distance between these times, and
%then separates neurons into clusters according to which neurons have high
%neural_activity close together in time.
%normalize is a boolean indicating whether to normalize the data, if the
%data is normalized, cutoff should be between 0 and 1.
%cutoff filters the data. If a neuron's activity never reaches cutoff, it
%will not be included.

%neural activity can be trace, C, C_raw, firing_rate etc.
if normalize==true
    max_activity=max(neural_activity,[],2);
    neural_activity=neural_activity./max_activity;
end

i=1;
current=1;
while i<length(neural_activity(:,1))
    if max(neural_activity(i,indexon:indexoff))>cutoff
        UnorderedIndices(current,1)=i;
        [M,I]=max(neural_activity(i,indexon:indexoff));
        UnorderedIndices(current,2)=I;
        current=current+1;
    end
    i=i+1;
end
OrderedIndexList=sortrows(UnorderedIndices,2);
diff=OrderedIndexList(2:end,2)-OrderedIndexList(1:end-1,2);

cluster_indices=[0];
for i=1:numclusters-1
    [M,I]=max(diff);
    diff(I)=0;
    cluster_indices=[cluster_indices,I];
end

cluster_indices=sort(cluster_indices);
cluster_indices=[cluster_indices,length(OrderedIndexList(:,2))];
%cluster_indices=[cluster_indices,length(cluster_indices)];

clusters=[];
for i=2:numclusters+1
  

    %size(clusters(i,1:cluster_indices(i)-cluster_indices(i-1)))
   
    clusters(i-1,1:cluster_indices(i)-cluster_indices(i-1))=OrderedIndexList(cluster_indices(i-1)+1:cluster_indices(i),1);
end    



