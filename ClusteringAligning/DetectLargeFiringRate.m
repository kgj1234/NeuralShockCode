function HighFiring=DetectLargeFiringRate(neural_activity,cutoff,indexon,indexoff)
%Calculates indices where neural activity is above a certain cutoff percentage in a time
%range bounded by timeon and timeoff
%cutoff should be between 0 and 1


max_activity=max(neural_activity,[],2);
neural_activity=neural_activity./max_activity;


HighFiring=zeros(length(neural_activity(:,1)),1);
for i=1:length(neural_activity(:,1))
    current=1;
    j=indexon;
    while j<=indexoff
        if neural_activity(i,j)>cutoff
            HighFiring(i,current)=j;
            current=current+1;
        end
        j=j+1;
    end
end