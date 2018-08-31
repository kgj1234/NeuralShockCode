function []=plotTransientsTrace(transients,trace,i)
%transients-cell array describing transients of each neuron
%trace-neuron traces
%i-neuron whose trace and transients we wish to plot



%Plot trace and transients for neuron i
len_trace=length(trace(i,:));
time=linspace(0,66*len_trace,len_trace);
plot(time,trace(i,:))
hold on
current_trans=transients{1,i};
for j=1:length(current_trans)
    plot([66*current_trans(j),66*current_trans(j)],[0,trace(i,current_trans(j))],'black')
end

