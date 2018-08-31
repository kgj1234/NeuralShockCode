%deprecated
function phase=combinemultipledaysmaxshock(phase,max_shock_vector)
for i=1:size(max_shock_vector,2)/2

    max_shock_vector(:,2*i-1:2*i)=sortrows(max_shock_vector(:,2*i-1:2*i),1);
end


new_max_shock=zeros(size(max_shock_vector,1),2);
new_max_shock(:,1)=1:size(max_shock_vector,1);

new_max_shock(:,2)=mean(max_shock_vector(:,2:2:end),2);
new_max_shock=sortrows(new_max_shock,2,'descend');
phase.max_shock=new_max_shock;
    