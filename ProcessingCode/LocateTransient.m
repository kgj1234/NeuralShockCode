function transients=LocateTransient(single_neuron_trace)
%single_neuron_trace-trace values for a single neuron


%Locate Maximums

maximums=[];
for i=2:length(single_neuron_trace)-1
    if single_neuron_trace(i)>single_neuron_trace(i-1)&&single_neuron_trace(i)>single_neuron_trace(i+1)
        maximums=[maximums,i];
    end
end

stdev=std(single_neuron_trace);
%Filter Maximums by magnitude
large_max=[];
for i=maximums
    if i>2*stdev
        large_max=[large_max,i];
    end
end

%Filter Maximums by mean in neighborhood of maximum
large_max_hval=[];
for i=large_max
    if i>4&&i<length(single_neuron_trace)-4
        if mean(single_neuron_trace(i-4:i+4))>2*stdev
            large_max_hval=[large_max_hval,i];
        end
    end
end
%Filter Maximum by distance between transients
if length(large_max_hval)>0
    transients=[large_max_hval(1)];
else
    transients=[];
end
for i=2:length(large_max_hval)-1
    %This condition determines if a transient lies to close to other
    %possible transients
    if large_max_hval(i)-transients(end)>=5 && large_max_hval(i+1)-large_max_hval(i)>=5
        transients=[transients,large_max_hval(i)];
    %If the transient is to close to the previous, we choose the transient with larger maximum trace    
    elseif large_max_hval(i)-transients(end)<5
        if single_neuron_trace(large_max_hval(i))>single_neuron_trace(transients(end))
            transients(end)=large_max_hval(i);
            %If we remove the current last transient, because it is to
            %small compared to a transient that is temporally close to it,
            %we check to see if we can add in the transient two steps
            %previous
            if i>2&&length(transients)>1
                if transients(end-1)~=large_max_hval(i-2)
                    if transients(end)-large_max_hval(i-2)>=5&&large_max_hval(i-2)-transients(end-1)>=5
                    
                        transients=[transients,large_max_hval(i-2)];
                        transients=sort(transients);
                    end
                end
            end
            
        end
    end
end
