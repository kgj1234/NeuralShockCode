function y=plotClusters(neural_activity,clusters,timeon, timeoff)
%plots neural activity for clusters already found. Gives as many plots as
%there are clusters
%neural_activity-firing_rate,S,trace,etc
%clusters-num_clusters by max_cluster_length matrix. 0's are placed in each
%row to ensure each row has the same length
%clusters can be calculated using code from the ClusteringAligning folder
%timeon,timeoff-inegers indicating the range over which to plot

N=length(clusters(:,1));
col=hsv(N);
time=linspace(timeon,66*timeoff,timeoff-timeon);
for i=1:N
    
    cluster_index=clusters(i,clusters(i,:)>0);
    plot(time,neural_activity(cluster_index,timeon:timeoff),'color',col(i,:));
    hold on
end