function PlotApproxTrace(trace,firing,scale,alpha)
x=linspace(0,length(trace)*66,length(trace));
approx=approximateTraceFromSpiking(firing,alpha);
figure()
plot(x,approx*scale)
hold on
plot(x,trace)
hold off
legend('approximation','trace')
