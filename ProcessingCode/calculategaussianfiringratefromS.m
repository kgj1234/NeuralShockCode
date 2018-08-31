function neuronIndividuals=calculategaussianfiringratefromS(neuronIndividuals,sigma,sz)
%sigma=100,sz=30
for j=1:length(neuronIndividuals)
    neuronIndividuals{j}.firing_rate=zeros(size(neuronIndividuals{j}.S));
    for i=1:size(neuronIndividuals{j}.S,1)
        neuronIndividuals{j}.firing_rate(i,:)=gaussFilter(neuronIndividuals{j}.S(i,:),sz,sigma);
    end
end

    

