function []=alignposition(neuron,behav)
%Aligns position data with  neuron time stamps
[correctdatatime,correctdatax,correctdatay]=correcteddata(behav);



[xvalues,yvalues]=positioninterpolation(neuron,correctdatatime,correctdatax,correctdatay);
neuron.position=horzcat(xvalues,yvalues);
behav1.position=behav.positionblue;
behav1.time=behav.time;
[correctdatatime,correctdatax,correctdatay]=correcteddata(behav1);



[xvalues,yvalues]=positioninterpolation(neuron,correctdatatime,correctdatax,correctdatay);
neuron.positionblue=horzcat(xvalues,yvalues);

behav1.position=horzcat(transpose(behav.speedblue),transpose(behav.speedblue));
[correctdatatime,correctdatax,correctdatay]=correcteddata(behav1);



[xvalues,yvalues]=positioninterpolation(neuron,correctdatatime,correctdatax,correctdatay);
neuron.speed=xvalues;





