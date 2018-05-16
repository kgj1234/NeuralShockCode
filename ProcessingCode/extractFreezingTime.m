%This is ineffective as the mouse may be grooming, instead of just frozen
%in fear
function freezetime=extractFreezingTime(speed,threshold)

freezetime=sum(speed<threshold)/length(speed);
