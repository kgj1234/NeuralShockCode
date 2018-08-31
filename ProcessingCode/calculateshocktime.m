function [shockstart,shockend]=calculateshocktime()
%Given video file, this extracts the frames for which the light glows green


'Video File'
[file,path]=uigetfile('*.avi');
video=strcat(path,file);
'Timestamp'
[file,path]=uigetfile('*.dat');
timestamp=strcat(path,file);


mov=VideoReader(video);
%nframes=mov.
mov=read(mov);
i=1;
shockstart=-10;
shockend=-10;
max_total=0;
totals=[];
while i<=1000
    frame=mov(:,:,:,i);
    total=sum(sum(sum(frame(20:40,70:105,:))));
    totals=[totals,total];
    if total>max_total;
        max_total=total;
    end
    if total>113000&&shockstart<0
        shockstart=i;
    elseif shockstart>0&&total<113000&&shockend<0&&i-shockstart<50
        shockstart=-10;
    elseif shockstart>0&&total<113000&&shockend<0&&i-shockstart>50
        shockend=i;
        break;
    end
    i=i+1;
end
max_total;
mean(totals);
timestamp=importdata(timestamp);
timestamp=timestamp.data;
timestampneuron=timestamp(timestamp(:,1)==0,:);
timestampbehav=timestamp(timestamp(:,1)==1,:);
[M,I]=min(abs(timestampneuron(:,3)-timestampbehav(shockstart,3)));
shockstart=floor(I/2);
[M,I]=min(abs(timestampneuron(:,3)-timestampbehav(shockend,3)));
shockend=floor(I/2);



