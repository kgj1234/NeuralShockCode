function [xvalues,yvalues]=positioninterpolation(Neuron,correctdatatime,correctdatax,correctdatay)

pp1=spline(correctdatatime,correctdatay);
yvalues=ppval(pp1,Neuron.time);


pp=spline(correctdatatime,correctdatax);
xvalues=ppval(pp,Neuron.time);







xvalues=smooth(xvalues,'rlowess');

yvalues=smooth(yvalues,'rlowess');
