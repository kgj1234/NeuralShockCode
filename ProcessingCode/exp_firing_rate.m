function firing_rate=exp_firing_rate(firing,sigma,sz);
firing_rate=zeros(size(firing));
x=1:sz+1;
exponent=exp(-1/sigma*x);
for j=1:size(firing,1)
    for i=1:size(firing,2)
        if firing(j,i)>0&& i<=size(firing,2)-sz
          
            firing_rate(j,i:i+sz)=firing_rate(j,i:i+sz)+firing(j,i).*exponent;
        elseif firing(j,i)>0&&i>size(firing,2)-sz
        
            firing_rate(j,i:end)=firing_rate(j,i:end)+firing(j,i).*exponent(1:size(firing,2)-i+1);
        end
    end
end