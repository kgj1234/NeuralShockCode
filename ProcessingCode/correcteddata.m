function [correctdatatime,correctdatax,correctdatay]=correcteddata(Behav)
behav.time=Behav.time;
behav.position=Behav.position;




%Get rid of time instances that are within 10 of each other
total=0;
correctdatatime=behav.time;
correctdatax=behav.position(:,1);

correctdatay=behav.position(:,2);
for i=length(behav.time)-1:-1:1
    if behav.time(i+1)-behav.time(i)<=10
        correctdatatime(i)=[];
        correctdatax(i)=[];
        correctdatay(i)=[];
        total=total+1;
    end
end

total
