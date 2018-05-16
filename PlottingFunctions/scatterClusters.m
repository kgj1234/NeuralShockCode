function []=scatterClusters(neuron,clusters)
%plots the centroids of the neurons in each cluster. This can be overlaid
%on top of the figure showing the identified neurons.
%neuron-sources2D neuron, or any other structure with centroid field.

N=length(clusters(:,1));
col=flipud(spring(N));

for i=1:N
    
    cluster_index=clusters(i,clusters(i,:)>0);
    scatter(neuron.centroid(cluster_index,2),neuron.centroid(cluster_index,1),[],col(i,:),'filled');
    hold on
end
legend()