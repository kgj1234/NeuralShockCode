function y=ApproxTrace(firing)
y=zeros(size(firing));

for i=1:length(firing(:,1))
    
    y(i,:)=approximateTraceFromSpiking(firing(i,:));
end