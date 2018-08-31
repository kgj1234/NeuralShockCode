function [firing,position,position_times]=ProcessSpikeData(pos,pos_times,spike_times,filename)
[pos,pos_times]=DownSampleBy2(pos,pos_times);
firing=CombineSpikeTimes(pos_times,spike_times);
firing=firing(sum(transpose(firing))>100,:);
position=pos;
position_times=pos_times;
dlmwrite(strcat(filename,'firing.txt'),firing);
dlmwrite(strcat(filename,'position.txt'),position);
dlmwrite(strcat(filename,'pos_times.txt'),position_times);