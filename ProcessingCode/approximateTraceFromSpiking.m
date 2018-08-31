function y=approximateTraceFromSpiking(firing)
%This parameter can be changed
alpha=.056;
y=zeros(1,length(firing));
x=linspace(1,length(firing),length(firing));

for i=1:length(firing)
    if firing(i)>0
       
        y(i:end)=y(i:end)+firing(i).*exp(-alpha.*(x(i:end)-x(i)));
    end
end
    