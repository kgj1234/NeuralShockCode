function transients=ConstructTransientCells(trace)
%trace-trace variable associated to experiment, typically around [89,10000]


%Compute transients for each neuron, and place them in a cell array
num_neurons=length(trace(:,1));
transients=cell(1,num_neurons);
for i=1:num_neurons
    
    transients{1,i}=LocateTransient(trace(i,:));
end
