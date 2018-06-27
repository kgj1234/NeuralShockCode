function firing_map=PlotFiringMap(single_neuron_activity,position,nrows,ncols,trackwidth,trackheight)
total_events=zeros(nrows,ncols);
total_firing=zeros(nrows,ncols);
firing_map=zeros(nrows,ncols);
position(:,2)=position(:,2)-min(position(:,2));
position(:,1)=position(:,1)-min(position(:,1));
position=position/(1.0000001);



for i=1:size(position,1)
    floor(position(i,2)/trackheight*nrows);
    height=nrows+1-(floor(position(i,2)/trackheight*nrows)+1);
    width=floor(position(i,1)/trackwidth*ncols)+1;
    total_events(height,width)=total_events(height,width)+1;
    total_firing(height,width)=total_firing(height,width)+single_neuron_activity(i);
end
for j=1:nrows
    for i=1:ncols
        if total_events(j,i)>0
            firing_map(j,i)=total_firing(j,i)/total_events(j,i);
        else
            firing_map(j,i)=0;
        end
    end
end
firing_map=imgaussfilt(firing_map);
imagesc(firing_map);
colorbar