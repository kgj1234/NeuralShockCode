function neuronprocessed=processData(Neuron,Behav,filename)
behav=Behav;
neuron=Neuron;
%load(Neuron);
%neuron
%load(Behav);
%behav
%Behav=behav;
%Neuron=neuron;
[correctdatatime,correctdatax,correctdatay]=correcteddata(Behav);

neuronprocessed.trace=Neuron.trace;
length(correctdatatime)
neuronprocessed.firing=Neuron.S;
[xvalues,yvalues]=positioninterpolation(Neuron,correctdatatime,correctdatax,correctdatay);

neuronprocessed.time=Neuron.time;
neuronprocessed.trackLength=behav.trackLength;
neuronprocessed.xpos=xvalues;

neuronprocessed.ypos=yvalues;
neuronprocessed.approxTrace=ApproxTrace(Neuron.S);




exporttext(filename,neuronprocessed)


%save('neuroncno.mat'); 