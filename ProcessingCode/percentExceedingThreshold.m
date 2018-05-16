%Deprecated
function per_exceeding=percentExceedingThreshold(neural_activity,time_vector,threshold)
%for i=1:length(neural_activity(:,1))
%    neural_activity(i,:)=neural_activity(i,:)/max(neural_activity(i,:));
%end
for i=1:length(neural_activity(:,1))
    per_exceeding(i)=sum(neural_activity(i,time_vector)>threshold);
    if sum(neural_activity(i,time_vector)>0)
        per_exceeding(i)=per_exceeding(i)/sum(neural_activity(i,time_vector)>0)*100;
    end
end