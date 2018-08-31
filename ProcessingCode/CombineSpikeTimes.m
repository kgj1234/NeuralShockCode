%This is poorly designed
function firing=CombineSpikeTimes(pos_times,spike_times)
firing=zeros(length(spike_times),length(pos_times));
for i=1:length(spike_times)
    
    spikes=spike_times(i);
    spikes=spikes{1,1};
  

    spikes=spikes(spikes(:)>pos_times(1));
  
    j=2;
    k=1;
    while j<=length(pos_times)&&k<=length(spikes)
        
        
        
         if spikes(k)<=pos_times(j)&&spikes(k)>pos_times(j-1)
             
             firing(i,j)=firing(i,j)+1;
             k=k+1;
         else
             j=j+1;
            
                
         end
            
           
    end
end
end