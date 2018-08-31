function [new_pos,new_pos_times]=DownSampleBy2(pos,pos_times)

for i=length(pos_times):-1:1
    if isnan(pos(i,1))||isnan(pos(i,2))
        pos(i,:)=[];
        pos_times(i)=[];
    end
end


new_pos=zeros(floor(length(pos_times)/2),2);

for i=1:floor(length(pos_times)/2)

    new_pos(i,1)=mean([pos(2*i,1),pos(2*i-1,1)]);
    new_pos(i,2)=mean([pos(2*i,2),pos(2*i-1,2)]);
end

new_pos_times=(pos_times(2:2:end)+pos_times(1:2:end-1))./2;
    
    
    