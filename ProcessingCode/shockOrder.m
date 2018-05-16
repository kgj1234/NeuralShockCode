%Deprecated
function neuron=shockOrder(neuron,filename)
neuron.max_shock=zeros(size(neuron.firing_rate,1),2);
neuron.max_shock(:,1)=1:size(neuron.firing_rate,1);
firing_rate=neuron.firing_rate;
for i=1:length(firing_rate(:,1))
    firing_rate(i,:)=firing_rate(i,:)/max(firing_rate(i,:));
end
neuron.max_shock(:,2)=max(firing_rate(:,neuron.shockstart:neuron.shockend),[],2);
%Switch these depending on whether extending the shocktime is desirable.
%neuron.max_shock(:,2)=max(firing_rate(:,neuron.shockstart:neuron.shockend+20),[],2);
neuron.max_shock=sortrows(neuron.max_shock,2,'descend');
%save(filename,'neuron')