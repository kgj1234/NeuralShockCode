function [clusters]=ClusterActivityPlot(neural_activity,num_per_cluster,start_clust_time,end_clust_time,start_plot_time,end_plot_time,normalize)
%neural_activity-firing_rate,C,S,num_neurons by num_time_points matrix
%num_per_cluster gives an upper bound on the possible number of neurons per
%cluster
%Uses k-means clustering to cluster neural activity based on correlation, from
%start_clust_time to end_clust_time, then they are plotted from
%start_plot_time to end_plot_time


%normalize-boolean indicating whether to normalize data

if normalize==true
    max_activity=max(neural_activity,[],2);
    neural_activity=neural_activity./max_activity;
end

clusters=kmeans(neural_activity(start_clust_time,end_clust_time),floor(length(neural_activity(:,1))/num_per_cluster));
for i=1:max(clusters)
    figure()
    plotActivityDivided(neural_activity(clusters==i,:),start_plot_time,end_plot_time)
end
