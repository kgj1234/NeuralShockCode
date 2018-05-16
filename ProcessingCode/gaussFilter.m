function gaussFilter=gaussFilter(x,sz,sigma)
x1 = linspace(-sz / 2, sz / 2, sz);
gaussFilter=exp(-x1.^2/(2*sigma)^2);
gaussFilter=gaussFilter/sum(gaussFilter);
gaussFilter=conv(x,gaussFilter,'same');