function maxshockdescription=extractmaxshockinfo(combineddaysneuron,extension_value)
%Detemrines value of maximum activity over shocktime, extended by some
%extension_value to account for activity taking place soon after shock

%combineddaysneuron-neuron containing data for several days (or 1 day if
%desired)

%extension_value-integer, activity taking place between
%shockend:shockend+extension_value will be counted as shock


%normalize neural activity by largest value
neuron=combineddaysneuron;
firing_rate=neuron.firing_rate;
size(firing_rate)
for i=1:length(firing_rate(:,1))
    if max(firing_rate(i,:))>0
        firing_rate(i,:)=firing_rate(i,:)/max(firing_rate(i,:));
    end
end

maxshockdescription=zeros(size(firing_rate,1),length(neuron.ShockBeg)+6);
maxshockdescription(:,1)=1:size(firing_rate,1);
for i=1:length(neuron.ShockBeg)

    maxshockdescription(:,i+1)=max(firing_rate(:,neuron.ShockBeg(i):(neuron.ShockEnd(i)+extension_value)),[],2);
end
maxshockdescription(:,length(neuron.ShockBeg)+2)=mean(maxshockdescription(:,2:length(neuron.ShockBeg)+1),2);
maxshockdescription(:,length(neuron.ShockBeg)+3)=std(maxshockdescription(:,2:length(neuron.ShockBeg)+1),[],2);
thresh=[.25,.5,.75];
time_vector=1:length(neuron.time);
for i=1:length(neuron.ShockBeg)
    time_vector=setdiff(time_vector,neuron.ShockBeg(i):(neuron.ShockEnd(i)+extension_value));
end
for i=1:length(thresh)
   maxshockdescription(:,length(neuron.ShockBeg)+3+i)=percentExceedingThreshold(firing_rate,time_vector,thresh(i));
end




