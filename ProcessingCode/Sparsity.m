function sparsity=Sparsity(single_neuron_activity,position,nrows,ncols,trackwidth,trackheight)
total_events=zeros(nrows,ncols);
total_firing=zeros(nrows,ncols);
firing_map=zeros(nrows,ncols);
position(:,2)=position(:,2)-min(position(:,2));
position(:,1)=position(:,1)-min(position(:,1));
position=position/(1.0000001);

%minimum_value=min(single_neuron_activity(single_neuron_activity>0))/5
mean_firing=0;
mean_variance=0;


for i=1:size(position,1)
    floor(position(i,2)/trackheight*nrows);
    height=nrows+1-(floor(position(i,2)/trackheight*nrows)+1);
    width=floor(position(i,1)/trackwidth*ncols)+1;
    total_events(height,width)=total_events(height,width)+1;
    %total_firing(height,width)=total_firing(height,width)+max(single_neuron_activity(i),minimum_value);
    total_firing(height,width)=total_firing(height,width)+single_neuron_activity(i);
end
no_position_data=[];
total_no_events=0;
for j=1:nrows
    for i=1:ncols
        if total_events(j,i)>9
            firing_map(j,i)=total_firing(j,i)/total_events(j,i);
        else
            total_no_events=total_no_events+1;
            no_position_data(total_no_events,:)=[j,i];
            
        end
    end
end

for j=1:nrows
    for i=1:ncols
        mean_firing=mean_firing+total_events(j,i)/size(position,1)*firing_map(j,i);
        mean_variance=mean_variance+total_events(j,i)/size(position,1)*firing_map(j,i)^2;
        
    end
end
sparsity=mean_firing^2/mean_variance;


