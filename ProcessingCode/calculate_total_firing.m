function firing_map_total=calculate_total_firing(neural_activity,position,nrows,ncols,neuron_subset)
firing_map_total=zeros(nrows,ncols);
for i=neuron_subset
    firing_map_total=firing_map_total+PlotFiringMap(neural_activity(i,:),position,nrows,ncols,.5,6);
end
