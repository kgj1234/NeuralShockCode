function y=exporttext(filename,neuron)
var=neuron.trace;
dlmwrite(strcat(filename,'trace.txt'),var);

var=neuron.firing;
dlmwrite(strcat(filename,'firing.txt'),var);
var=neuron.time;

dlmwrite(strcat(filename,'time.txt'),var);
var=neuron.xpos;
dlmwrite(strcat(filename,'xpos.txt'),var);
var=neuron.ypos;
dlmwrite(strcat(filename,'ypos.txt'),var);
y=1;
var=neuron.trackLength;
dlmwrite(strcat(filename,'tracklength.txt'),var);
var=neuron.approxTrace;
dlmwrite(strcat(filename,'approxTrace.txt'),var);