function firing_rate=extractFiringRate(firing,sigma,sz)
firing_rate=zeros(size(firing));
for i=1:size(firing,1)
   firing_rate(i,:)=gaussFilter(firing(i,:),sz,sigma);
end